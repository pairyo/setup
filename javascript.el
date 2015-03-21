;;==== javascript ====
(add-to-list 'load-path "~/.emacs.d/.cask/24.4.1/elpa/tern-20150302.211/")
(autoload 'tern-mode "tern.el" nil t)

(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook '(lambda()
			    (message "js2-mode is on")
			    (ac-js2-mode)
			    (tern-mode)
			    (flycheck-mode t)
			    (electric-indent-mode -1)
			    (setq tab-width 2)
			    (set-variable 'indent-tabs-mode nil)))

(add-hook 'jsx-mode-hook (lambda ()
			   (tern-mode t)
			   (ac-js2-mode t)
	   		   (flycheck-select-checker 'jsxhint-checker) (flycheck-mode)
			   (auto-complete-mode 1)
			   ))
(add-hook 'js-mode-hook 'js2-minor-mode)
(define-key js2-mode-map "{" 'paredit-open-curly)
(define-key js2-mode-map "}" 'paredit-close-curly-and-newline)
;;---- tern ----
(eval-after-load 'tern '(progn (require 'tern-auto-complete) (tern-ac-setup)))
(defun tern-kill-process () (interactive) (delete-process "Tern"))
(add-hook 'js2-mode-hook 'my-paredit-nonlisp)

;==== Web mode ====
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

;---- flycheck ----
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
