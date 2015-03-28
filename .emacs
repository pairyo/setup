(require 'package)
(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")
                  ("melpa" . "http://melpa.milkbox.net/packages/")
                  ))
  (add-to-list 'package-archives source t))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))
 (defvar hophacker/packages
  '(js2-mode scala-mode2 ac-js2 js2-refactor tern tern-auto-complete ensime projectile hippie-expand-slime magit zenburn-theme auto-complete
	     robe rvm flymake-ruby inf-ruby projectile-rails))

(dolist (p hophacker/packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;#### requires ####
(require 'ido)
(require 'ensime)
(require 'zenburn-theme)
(require 'robe)
(require 'auto-complete)(auto-complete-mode t)


;;#### General ####
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(setq default-directory "~/hophacker/myriad/darkroom")
(global-linum-mode 1)
(projectile-global-mode)
(setq make-backup-files nil)
(tool-bar-mode -1)
(ido-mode t)
(global-company-mode t)
(push 'company-robe company-backends)

;;==== scala/sbt ====
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)
(setq ruby-deep-indent-paren nil)

;;==== Ruby on Rails ====
(setq ruby-deep-indent-paren nil)
(global-set-key (kbd "C-c r a") 'rvm-activate-corresponding-ruby)
(global-set-key (kbd "C-c r r") 'inf-ruby)
(add-hook 'projectile-mode-hook 'projectile-rails-on)
(add-hook 'ruby-mode-hook 'robe-mode)
(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
             (rvm-activate-corresponding-ruby))

;;==== Javascript ====
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


;;#### Plugins ####
;;---- ido ----
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
(defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
(add-hook 'ido-setup-hook 'ido-define-keys)

;;#### Functions ####
(defun load-dot-emacs () (interactive) (load-file "~/.emacs"))
(defun open-dot-emacs () (interactive) (find-file-other-window "~/.emacs"))
;;---- hippie-expand ----
(defun my-expand-file-name-at-point ()
  "Use hippie-expand to expand the filename"
  (interactive)
  (let ((hippie-expand-try-functions-list '(try-complete-file-name-partially try-complete-file-name)))
    (call-interactively 'hippie-expand)))

;;#### Mappings ####
(global-set-key (kbd "C-x e") 'open-dot-emacs)
(global-set-key (kbd "C-x i") 'package-install)
(global-set-key (kbd "s-i") 'indent-region)
(global-set-key (kbd "C-x l") 'load-dot-emacs)
(global-set-key (kbd "C-x m") 'magit-status)
(global-set-key (kbd "s-o") 'projectile-find-file)

(global-set-key (kbd "C-s-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-s-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-s-<down>") 'shrink-window)
(global-set-key (kbd "C-s-<up>") 'enlarge-window)
(global-set-key (kbd "C-M-f") 'my-expand-file-name-at-point)

(define-key projectile-mode-map (kbd "s-s") 'projectile-persp-switch-project)
