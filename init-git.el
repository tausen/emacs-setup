;; git plugin
(add-to-list 'load-path "~/.emacs.d/lib/magit-1.2.0/")
(require 'magit)
(global-set-key (kbd "C-c g") 'magit-status)
; (magit-status-buffer-switch-function (quote switch-to-buffer))
; (magit-status-buffer-switch-function (quote pop-to-buffer))

(setenv "GIT_EDITOR" "emacsclient")
(setenv "EDITOR" "emacsclient")
