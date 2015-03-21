(require 'package)
(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")
                  ;; TODO: Maybe, use this after emacs24 is released
                  ;; (development versions of packages)
                  ("melpa" . "http://melpa.milkbox.net/packages/")
                  ))
  (add-to-list 'package-archives source t))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))
(defvar tmtxt/packages
  '(js2-mode ac-js2 js2-refactor tern tern-auto-complete ensime projectile hippie-expand-slime magit zenburn-theme auto-complete))
(dolist (p tmtxt/packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;#### requires ####
(require 'ensime)
(require 'zenburn-theme)
(require 'auto-complete)(auto-complete-mode t)


;;#### General ####
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(setq default-directory "~/hophacker/myriad/darkroom")
(global-linum-mode 1)
(projectile-global-mode)
(setq make-backup-files nil)

;;==== scala/sbt ====
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

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
(global-set-key (kbd "C-x d") 'duplicate-line)
(global-set-key (kbd "C-x e") 'open-dot-emacs)
(global-set-key (kbd "C-x i") 'package-install)
(global-set-key (kbd "C-x l") 'load-dot-emacs)
(global-set-key (kbd "C-x m") 'magit-status)
(global-set-key (kbd "C-x f") 'projectile-find-file)

(global-set-key (kbd "C-s-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-s-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-s-<down>") 'shrink-window)
(global-set-key (kbd "C-s-<up>") 'enlarge-window)
(global-set-key (kbd "C-M-f") 'my-expand-file-name-at-point)
