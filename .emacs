;; mapping introduction
;; s- : short and most used

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

;;for scala and sbt
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(package-initialize)
(when (not package-archive-contents) (package-refresh-contents))



(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)


(projectile-global-mode)

(global-linum-mode 1)
(setq make-backup-files nil)

;javascript
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq js2-highlight-level 3)

(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

(require 'jsx-mode)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))



;yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;;; auto complete mod, should be loaded after yasnippet so that they can work together
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

(cd "~/hophacker/myriad")


(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)
(defun load-dot-emacs () (interactive) (load-file "~/.emacs"))
(defun open-dot-emacs () (interactive) (find-file-other-window "~/.emacs"))

;mouse
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] '(lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
)

(require 'button-lock)
(global-button-lock-mode 1)
(setq url-button (button-lock-set-button "\\<http://[^[:space:]\n]+"
					 'browse-url-at-mouse
					 :face 'link :face-policy 'prepend))
(add-to-list 'custom-theme-load-path
	     (file-name-as-directory "~/.emacs.d/replace-colorthemes"))

;; load your favorite theme
(load-theme 'desert t t)
(enable-theme 'desert)


;; auto refresh file when it gets changed outside
(global-auto-revert-mode t)

;(eval-after-load 'js-mode  (define-key js-mode-map "{" 'paredit-open-curly))

;(eval-after-load 'js-mode  (define-key js-mode-map "}" 'paredit-open-curly-and-newline))

;; paredit
(defun my-paredit-nonlisp ()
  "Turn on paredit mode for non-lisps."
  (interactive)
  (set (make-local-variable 'paredit-space-for-delimiter-predicates)
       '((lambda (endp delimiter) nil)))
  (paredit-mode 1))

(add-hook 'js-mode-hook 'my-paredit-nonlisp)

; javascript
;; web mode
(require 'flycheck) 
(flycheck-define-checker jsxhint-checker
  "A JSX syntax and style checker based on JSXHint."
  :command ("jsxhint" source)
  :error-patterns
  ((error line-start (1+ nonl) ": line " line ", col " column ", " (message) line-end))
  :modes (web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (equal web-mode-content-type "jsx")
              ;; enable flycheck
              (flycheck-select-checker 'jsxhint-checker)
              (flycheck-mode))))


(setq jsx-indent-level 2)
(setq js-indent-level 2)

(require 'flycheck)
(flycheck-define-checker jsxhint-checker
  "A JSX syntax and style checker based on JSXHint."
  :command ("jsxhint" source)
  :error-patterns
  ((error line-start (1+ nonl) ": line " line ", col " column ", " (message) line-end))
  :modes (jsx-mode))
(add-hook 'jsx-mode-hook (lambda ()
                          (flycheck-select-checker 'jsxhint-checker)
                          (flycheck-mode)))


(add-hook 'jsx-mode-hook
          (lambda () (auto-complete-mode 1)))
;; tern-mode
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(add-hook 'jsx-mode-hook (lambda () (tern-mode t)))

(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))

(defun tern-kill-process ()
  (interactive)
  (delete-process "Tern"))


(setq yas/root-directory "~/hophacker/yasnippets")

(setq default-directory "~/hophacker/myriad/cbt")
(cd "~/hophacker/myriad/cbt")

(require 'pbcopy)
(turn-on-pbcopy)

;; markdown
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; mappings
(global-set-key (kbd "C-s-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-s-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-s-<down>") 'shrink-window)
(global-set-key (kbd "C-s-<up>") 'enlarge-window)
(global-set-key (kbd "C-x f") 'projectile-find-file)
(global-set-key (kbd "s-f") 'comint-dynamic-complete-filename)
(global-set-key (kbd "C-x i") 'package-install)
(global-set-key (kbd "C-x d") 'duplicate-line)
(global-set-key (kbd "C-x f") 'projectile-find-file)
(global-set-key (kbd "C-x l") 'load-dot-emacs)
(global-set-key (kbd "C-x e") 'open-dot-emacs)
(global-set-key (kbd "C-x m") 'magit-status)
