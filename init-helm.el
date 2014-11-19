(add-to-list 'load-path "~/.emacs.d/lib/async")
(add-to-list 'load-path "~/.emacs.d/lib/helm")
(require 'helm-config)

(helm-mode 1)

(global-set-key (kbd "C-c h") 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-c C-x C-b") 'ibuffer)
(global-set-key (kbd "C-c s h") 'helm-do-grep)

;; Bind smex M-x to C-c M-x
(add-to-list 'load-path "~/.emacs.d/lib/smex/")
(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                  ; when Smex is auto-initialized on its first run.
(global-set-key (kbd "C-c M-x") 'smex)

(load "~/.emacs.d/lib/projectile/helm-projectile.el")
(require 'helm-projectile)
(helm-projectile-on)
