;;http://writequit.org/org/settings.html#sec-1-1
;;(setq debug-on-error t)
(global-auto-revert-mode t)
(setenv "PATH" (concat "/usr/local/bin/:" (getenv "PATH")))
(require 'package)
(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")
                  ("gnu" . "http://elpa.gnu.org/packages/")
                  ("melpa" . "http://melpa.org/packages/")
                  ))
  (add-to-list 'package-archives source t))
(package-initialize)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
(exec-path-from-shell-copy-env "PATH")


(when (not package-archive-contents)
  (package-refresh-contents))
(defvar hophacker/packages
  '(js2-mode scala-mode2 ac-js2 js2-refactor tern tern-auto-complete ensime projectile hippie-expand-slime magit zenburn-theme auto-complete robe
	     helm helm-descbinds use-package paredit vkill ace-jump-mode ace-jump-buffer helm-projectile exec-path-from-shell company
	     rvm flymake-ruby inf-ruby projectile-rails))

(dolist (p hophacker/packages)
  (when (not (package-installed-p p))
    (package-install p)))
;;#### variables ####
(setq grep-file-types "*.{scala,rb,js,jsx,html,css,scss,sass}")
;;#### requires ####
(require 'ido)
(require 'use-package)
(require 'ensime)
(require 'zenburn-theme)
(require 'robe)
(require 'auto-complete)(auto-complete-mode t)

;;#### General ####
(add-hook 'after-init-hook 'global-company-mode)
(setq echo-keystrokes 0.1)
(setq default-directory "~/hophacker/myriad/cbt/darkroom")
(global-linum-mode 1)
(projectile-global-mode)
(setq make-backup-files nil)
(tool-bar-mode -1)
(global-company-mode t)
(push 'company-robe company-backends)
(setq ring-bell-function (lambda()))
(setq inhibit-startup-message t
      initial-major-mode 'fundamental-mode)
(line-number-mode 1)
(column-number-mode 1)
(setq read-file-name-completion-ignore-case t) ;ignore case when using completion for file names
(defalias 'yes-or-no-p 'y-or-n-p)
(setq line-move-visual t)
(setq-default fill-column 80)
(setq-default default-tab-width 2)
(setq-default indent-tabs-mode nil)
(setq-default find-file-visit-truename t)
;;search/replace with regex by default
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'query-replace-regexp)
(set-default 'indicate-empty-lines t)
(setq show-trailing-whitespace t)
;;display time

(add-to-list 'load-path "~/.emacs.d/elpa/tern-20150302.211")
(autoload 'tern-mode "tern.el" nil t)
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . js2-mode))

(add-hook 'js2-mode-hook 'ac-js2-mode)

(setq js2-highlight-level 3)

(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))

(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

;;#### Functions ####
; when I start emacs in a directory, it becomes the root directory 
(defvar root-dir default-directory)
(defun helm-do-grep-recursive ()
  "Like `helm-do-grep', but greps recursively by default and targeting the root directory."
  ;; still using interactive, as we need to be able to ask for the pattern and files type
  (interactive)
    (helm-do-grep-1 (list root-dir) t grep-file-types))
(defun load-dot-emacs () (interactive) (load-file "~/.emacs"))
(defun open-dot-emacs () (interactive) (find-file-other-window "~/.emacs"))
;;---- hippie-expand ----
(defun my-expand-file-name-at-point ()
  "Use hippie-expand to expand the filename"
  (interactive)
  (let ((hippie-expand-try-functions-list '(try-complete-file-name-partially try-complete-file-name)))
    (call-interactively 'hippie-expand)))


;;#### Plugins ####
(use-package rbenv
  :disabled t
  :init (global-rbenv-mode t))

(use-package helm
  :bind
  (("C-M-z" . helm-resume)
   ("C-x C-f" . helm-find-files)
   ("C-h b" . helm-descbinds)
   ("C-x C-r" . helm-mini)
   ("C-x M-o" . helm-occur)
   ("M-y" . helm-show-kill-ring)
   ("C-h a" . helm-apropos)
   ("C-h m" . helm-man-woman)
   ("M-g >" . helm-ag-this-file)
   ("M-g ," . helm-ag-pop-stack)
   ("s-g" . helm-do-grep)
   ("s-G" . helm-do-grep-recursive)
   ("C-x C-i" . helm-semantic-or-imenu)
   ("M-x" . helm-M-x)
   ("C-x C-b" . helm-buffers-list)
   ("C-x C-r" . helm-mini)
   ("C-x b" . helm-mini)
   ("C-h t" . helm-world-time))
  :init (progn
          ;;(helm-autoresize-mode 1)
          (helm-mode 1))
  :diminish ""
  :config
  (progn
    (use-package helm-config)
    (use-package helm-files)
    (use-package helm-grep
      :config
      (progn
        (define-key helm-grep-mode-map (kbd "<return>")  'helm-grep-mode-jump-other-window)
        (define-key helm-grep-mode-map (kbd "n")  'helm-grep-mode-jump-other-window-forward)
        (define-key helm-grep-mode-map (kbd "p")  'helm-grep-mode-jump-other-window-backward)))
    (use-package helm-man)
    (use-package helm-misc)
    (use-package helm-aliases)
    (use-package helm-elisp)
    (use-package helm-imenu)
    (use-package helm-semantic)
    (use-package helm-ring)
    (use-package helm-bookmark
      :bind (("C-x M-b" . helm-bookmarks)))
    (use-package helm-projectile
      :bind (("C-x f" . helm-projectile)
             ("C-c p f" . helm-projectile-find-file)
             ("C-c p s" . helm-projectile-switch-project)))
    (use-package helm-eshell
      :init (add-hook 'eshell-mode-hook
                      (lambda ()
                        (define-key eshell-mode-map (kbd "M-l")
                          'helm-eshell-history))))
    (use-package helm-descbinds
      :init (helm-descbinds-mode t))
    (use-package helm-ag
      :bind ("C-M-s" . helm-ag-this-file))

    ;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
    ;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
    ;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
    (global-set-key (kbd "C-c h") 'helm-command-prefix)
    (global-unset-key (kbd "C-x c"))

    (setq helm-idle-delay 0.1
          helm-exit-idle-delay 0.1
          helm-input-idle-delay 0
          helm-buffers-fuzzy-matching t
          ;; truncate long lines in helm completion
          helm-truncate-lines t
          ;; may be overridden if 'ggrep' is in path (see below)
          helm-grep-default-command
          (concat "ggrep -a -d skip %e -n%cH -e %p %f --include=" grep-file-types)
          helm-grep-default-recurse-command
	  (concat "ggrep  -a -d recurse %e -n%cH -e %p %f --include=" grep-file-types)
          ;; do not display invisible candidates
          helm-quick-update t
          ;; be idle for this many seconds, before updating in delayed sources.
          helm-idle-delay 0.01
          ;; be idle for this many seconds, before updating candidate buffer
          helm-input-idle-delay 0.01
          ;; open helm buffer in another window
          helm-split-window-default-side 'other
          ;; open helm buffer inside current window, don't occupy whole other window
          helm-split-window-in-side-p t
          ;; limit the number of displayed canidates
          helm-candidate-number-limit 200
          ;; don't use recentf stuff in helm-ff
          helm-ff-file-name-history-use-recentf nil
          ;; move to end or beginning of source when reaching top or bottom
          ;; of source
          helm-move-to-line-cycle-in-source t
          ;; don't displace the header line
          helm-display-header-line nil
          ;; fuzzy matching
          helm-buffers-fuzzy-matching t
          helm-semantic-fuzzy-match t
          helm-imenu-fuzzy-match t
          helm-completion-in-region-fuzzy-match t
          ;; Here are the things helm-mini shows, I add `helm-source-bookmarks'
          ;; here to the regular default list
          helm-mini-default-sources '(helm-source-buffers-list
                                      helm-source-recentf
                                      helm-source-bookmarks
                                      helm-source-buffer-not-found))

    ;; List of times to show in helm-world-time
    (setq display-time-world-list '(("PST8PDT" "Los Altos")
                                    ("America/Denver" "Denver")
                                    ("EST5EDT" "Boston")
                                    ("UTC" "UTC")
                                    ("Europe/London" "London")
                                    ("Europe/Amsterdam" "Amsterdam")
                                    ("Asia/Bangkok" "Bangkok")
                                    ("Asia/Tokyo" "Tokyo")
                                    ("Australia/Sydney" "Sydney")))

    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
    (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
    (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

    (define-key helm-map (kbd "C-p")   'helm-previous-line)
    (define-key helm-map (kbd "C-n")   'helm-next-line)
    (define-key helm-map (kbd "C-M-n") 'helm-next-source)
    (define-key helm-map (kbd "C-M-p") 'helm-previous-source)
    ;; The normal binding is C-c h M-g s which is insane
    (global-set-key (kbd "C-c h g")    'helm-do-grep)
    (global-set-key (kbd "C-c h a")    'helm-do-ag)

    (when (executable-find "curl")
      (setq helm-google-suggest-use-curl-p t))

    ;; ggrep is gnu grep on OSX
    (when (executable-find "ggrep")
      (setq helm-grep-default-command
            "ggrep -a -d skip %e -n%cH -e %p %f"
            helm-grep-default-recurse-command
            "ggrep -a -d recurse %e -n%cH -e %p %f"))

    (define-key helm-map (kbd "C-x 2") 'helm-select-2nd-action)
    (define-key helm-map (kbd "C-x 3") 'helm-select-3rd-action)
    (define-key helm-map (kbd "C-x 4") 'helm-select-4rd-action)

    ;; helm-mini instead of recentf
    (define-key 'help-command (kbd "C-f") 'helm-apropos)
    (define-key 'help-command (kbd "r") 'helm-info-emacs)

    ;; use helm to list eshell history
    (add-hook 'eshell-mode-hook
              #'(lambda ()
                  (define-key eshell-mode-map (kbd "M-l")  'helm-eshell-history)))

    ;; Save current position to mark ring
    ;; (add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)

    (defvar helm-httpstatus-source
      '((name . "HTTP STATUS")
        (candidates . (("100 Continue") ("101 Switching Protocols")
                       ("102 Processing") ("200 OK")
                       ("201 Created") ("202 Accepted")
                       ("203 Non-Authoritative Information") ("204 No Content")
                       ("205 Reset Content") ("206 Partial Content")
                       ("207 Multi-Status") ("208 Already Reported")
                       ("300 Multiple Choices") ("301 Moved Permanently")
                       ("302 Found") ("303 See Other")
                       ("304 Not Modified") ("305 Use Proxy")
                       ("307 Temporary Redirect") ("400 Bad Request")
                       ("401 Unauthorized") ("402 Payment Required")
                       ("403 Forbidden") ("404 Not Found")
                       ("405 Method Not Allowed") ("406 Not Acceptable")
                       ("407 Proxy Authentication Required") ("408 Request Timeout")
                       ("409 Conflict") ("410 Gone")
                       ("411 Length Required") ("412 Precondition Failed")
                       ("413 Request Entity Too Large")
                       ("414 Request-URI Too Large")
                       ("415 Unsupported Media Type")
                       ("416 Request Range Not Satisfiable")
                       ("417 Expectation Failed") ("418 I'm a teapot")
                       ("422 Unprocessable Entity") ("423 Locked")
                       ("424 Failed Dependency") ("425 No code")
                       ("426 Upgrade Required") ("428 Precondition Required")
                       ("429 Too Many Requests")
                       ("431 Request Header Fields Too Large")
                       ("449 Retry with") ("500 Internal Server Error")
                       ("501 Not Implemented") ("502 Bad Gateway")
                       ("503 Service Unavailable") ("504 Gateway Timeout")
                       ("505 HTTP Version Not Supported")
                       ("506 Variant Also Negotiates")
                       ("507 Insufficient Storage") ("509 Bandwidth Limit Exceeded")
                       ("510 Not Extended")
                       ("511 Network Authentication Required")))
        (action . message)))

    (defvar helm-clj-http-source
      '((name . "clj-http options")
        (candidates
         .
         ((":accept - keyword for content type to accept")
          (":as - output coercion: :json, :json-string-keys, :clojure, :stream, :auto or string")
          (":basic-auth - string or vector of basic auth creds")
          (":body - body of request")
          (":body-encoding - encoding type for body string")
          (":client-params - apache http client params")
          (":coerce - when to coerce response body: :always, :unexceptional, :exceptional")
          (":conn-timeout - timeout for connection")
          (":connection-manager - connection pooling manager")
          (":content-type - content-type for request")
          (":cookie-store - CookieStore object to store/retrieve cookies")
          (":cookies - map of cookie name to cookie map")
          (":debug - boolean to print info to stdout")
          (":debug-body - boolean to print body debug info to stdout")
          (":decode-body-headers - automatically decode body headers")
          (":decompress-body - whether to decompress body automatically")
          (":digest-auth - vector of digest authentication")
          (":follow-redirects - boolean whether to follow HTTP redirects")
          (":form-params - map of form parameters to send")
          (":headers - map of headers")
          (":ignore-unknown-host? - whether to ignore inability to resolve host")
          (":insecure? - boolean whether to accept invalid SSL certs")
          (":json-opts - map of json options to be used for form params")
          (":keystore - file path to SSL keystore")
          (":keystore-pass - password for keystore")
          (":keystore-type - type of SSL keystore")
          (":length - manually specified length of body")
          (":max-redirects - maximum number of redirects to follow")
          (":multipart - vector of multipart options")
          (":oauth-token - oauth token")
          (":proxy-host - hostname of proxy server")
          (":proxy-ignore-hosts - set of hosts to ignore for proxy")
          (":proxy-post - port for proxy server")
          (":query-params - map of query parameters")
          (":raw-headers - boolean whether to return raw headers with response")
          (":response-interceptor - function called for each redirect")
          (":retry-handler - function to handle HTTP retries on IOException")
          (":save-request? - boolean to return original request with response")
          (":socket-timeout - timeout for establishing socket")
          (":throw-entire-message? - whether to throw the entire response on errors")
          (":throw-exceptions - boolean whether to throw exceptions on 5xx & 4xx")
          (":trust-store - file path to trust store")
          (":trust-store-pass - password for trust store")
          (":trust-store-type - type of trust store")))
        (action . message)))

    (defun helm-httpstatus ()
      (interactive)
      (helm-other-buffer '(helm-httpstatus-source) "*helm httpstatus*"))

    (defun helm-clj-http ()
      (interactive)
      (helm-other-buffer '(helm-clj-http-source) "*helm clj-http flags*"))

    (global-set-key (kbd "C-c M-C-h") 'helm-httpstatus)
    (global-set-key (kbd "C-c M-h") 'helm-clj-http)

    (use-package helm-swoop
      :bind (("M-i" . helm-swoop)
             ("M-I" . helm-swoop-back-to-last-point)
             ("C-c M-i" . helm-multi-swoop))
      :config
      (progn
        ;; When doing isearch, hand the word over to helm-swoop
        (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
        ;; From helm-swoop to helm-multi-swoop-all
        (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
        ;; Save buffer when helm-multi-swoop-edit complete
        (setq helm-multi-swoop-edit-save t
              ;; If this value is t, split window inside the current window
              helm-swoop-split-with-multiple-windows nil
              ;; Split direcion. 'split-window-vertically or 'split-window-horizontally
              helm-swoop-split-direction 'split-window-vertically
              ;; If nil, you can slightly boost invoke speed in exchange for text color
              helm-swoop-speed-or-color nil)))
    ))
;;---- ido ----
(use-package ido
  :commands (ido-next-match ido-prev-match)
  :init
  (setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
  (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
  (defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
    (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
    (define-key ido-completion-map (kbd "C-p") 'ido-prev-match)
    )
  (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
  (add-hook 'ido-setup-hook 'ido-define-keys)
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (setq ido-file-extensions-order '(".scala", ".js", ".jsx", ".css", ".scss", ".sass",  ".org" ".txt" ".py" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf"))
  (ido-mode 1)
  )

;;---- paredit ----
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'ruby-mode #'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)


;;#### advices ####
;;Never kill *scratch*
(defadvice kill-buffer (around kill-buffer-around-advice activate)
  (let ((buffer-to-kill (ad-get-arg 0)))
    (if (equal buffer-to-kill "*scratch*")
        (bury-buffer)
      ad-do-it)))
;;#### Mappings ####
(global-set-key (kbd "s-i") 'indent-region)
(global-set-key (kbd "s-f") 'projectile-find-file)
(global-set-key (kbd "C-c r r") 'inf-ruby)

(global-set-key (kbd "C-x e") 'open-dot-emacs)
(global-set-key (kbd "C-x i") 'package-install)

(global-set-key (kbd "C-x l") 'load-dot-emacs)
(global-set-key (kbd "C-x m") 'magit-status)


(global-set-key (kbd "C-s-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-s-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-s-<down>") 'shrink-window)
(global-set-key (kbd "C-s-<up>") 'enlarge-window)
(global-set-key (kbd "C-M-/") 'my-expand-file-name-at-point)
(global-set-key (kbd "<tab>") 'company-complete)


(define-key projectile-mode-map (kbd "s-s") 'projectile-persp-switch-project)

;;#### Tools ####
(use-package vkill
  :commands vkill
  :bind ("C-x L" . vkill-and-helm-occur)
  :init
  (defun vkill-and-helm-occur ()
    (interactive)
    (vkill)
    (hl-line-mode 1)
    (call-interactively #'helm-occur)))
(use-package ace-jump-mode
  :bind (("C-c SPC" . ace-jump-mode)
         ("C-c M-SPC" . ace-jump-line-mode)))
(message (getenv "PATH"))

;;#### Hook ####
(add-hook 'projectile-mode-hook 'projectile-rails-on)
