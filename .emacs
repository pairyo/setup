;;http://writequit.org/org/settings.html#sec-1-1
(setq debug-on-error t)
(global-auto-revert-mode t)
(require 'package)
(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")
                  ("gnu" . "http://elpa.gnu.org/packages/")
                  ("melpa" . "http://melpa.org/packages/")
                  ))
  (add-to-list 'package-archives source t))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))
(defvar hophacker/packages
  '(js2-mode ac-js2 js2-refactor tern tern-auto-complete
             scala-mode2 ensime
             projectile hippie-expand-slime magit zenburn-theme auto-complete robe yasnippet
	     helm helm-descbinds use-package paredit vkill ace-jump-mode ace-jump-buffer helm-projectile exec-path-from-shell company restclient
	     rvm flymake-ruby inf-ruby projectile-rails))
(dolist (p hophacker/packages)
  (when (not (package-installed-p p))
    (package-install p)))

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
(exec-path-from-shell-copy-env "PATH")
(setq exec-path (append exec-path '("/usr/local/bin")))

;;#### variables ####
(setq grep-file-types "*.{scala,rb,js,jsx,html,css,scss,sass}")
;;#### requires ####
(require 'ido)
(require 'use-package)
(require 'ensime)
(require 'zenburn-theme)
(require 'robe)
(require 'auto-complete)(auto-complete-mode t)
;;#### emacs-livedown  ####
; before using this: git clone git@github.com:shime/emacs-livedown.git ~/.emacs.d/emacs-livedown
(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-livedown"))
(require 'livedown)
(global-set-key (kbd "C-M-m") 'livedown:preview)
;;#### General ####
;;(yas-reload-all)
;;yas-begin
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"                 ;; personal snippets
        "~/.emacs.d/yasnippet/snippets/" ;; the yasmate collection
        "~/.emacs.d/yasnippet/yasmate/snippets/"         ;; the default collection
        ))

(yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.
;;yas-end
(add-hook 'after-init-hook 'global-company-mode)
(setq echo-keystrokes 0.1)
(setq default-directory "~/pairyo")
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

;;markdown livedown 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js2-basic-offset 2)
 '(livedown:autostart nil)
 '(livedown:open t)
 '(livedown:port 1337))
    ; port for livedown server

;;(add-hook 'js2-mode-hook 'ac-js2-mode)

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

(load-file "~/setups/emacs/helm.el")
(load-file "~/setups/emacs/ido.el")

;;---- paredit ----
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'ruby-mode #'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'gfm-mode-hook           #'enable-paredit-mode)
(add-hook 'js2-mode-hook           #'enable-paredit-mode)


;;#### advices ####
;;Never kill *scratch*
(defadvice kill-buffer (around kill-buffer-around-advice activate)
  (let ((buffer-to-kill (ad-get-arg 0)))
    (if (equal buffer-to-kill "*scratch*")
        (bury-buffer)
      ad-do-it)))
;;#### Mappings ####
(global-set-key (kbd "M-\\") 'comint-dynamic-complete-filename) ;;file completiong
(global-set-key (kbd "s-i") 'indent-region)
(global-set-key (kbd "s-f") 'projectile-find-file)
(global-set-key (kbd "C-c r r") 'inf-ruby)

(global-set-key (kbd "C-c e") 'open-dot-emacs)
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
l  :bind ("C-x L" . vkill-and-helm-occur)
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
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'scroll-left 'disabled nil)
