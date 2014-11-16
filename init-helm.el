(add-to-list 'load-path "~/.emacs.d/lib/async")
(add-to-list 'load-path "~/.emacs.d/lib/helm")
(require 'helm-config)

;; (load "~/.emacs.d/lib/projectile/helm-projectile.el")
;; (require 'helm-projectile)

(helm-mode 1)
;; (helm-projectile-on)

(global-set-key (kbd "C-c C-h") 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
;; (global-set-key (kbd "C-c C-p C-h") 'helm-projectile)
;; (global-set-key (kbd "C-c C-p C-f") 'helm-projectile-find-file)
;; (global-set-key (kbd "C-c C-p C-p") 'helm-projectile-switch-project)

;; override hotkey in python-mode
;; (add-hook 'python-mode-hook (lambda () (local-unset-key (kbd "C-c C-p"))))
;; (add-hook 'python-mode-hook (lambda () (local-set-key (kbd "C-c C-p C-h") 'helm-projectile)))

;; Bind smex M-x to C-c M-x
(add-to-list 'load-path "~/.emacs.d/lib/smex/")
(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                  ; when Smex is auto-initialized on its first run.
(global-set-key (kbd "C-c M-x") 'smex)
