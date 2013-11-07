;; git plugin
(require 'magit)
(global-set-key (kbd "C-c g") 'magit-status)
; (magit-status-buffer-switch-function (quote switch-to-buffer))
; (magit-status-buffer-switch-function (quote pop-to-buffer))

(setenv "EDITOR" "emacsclient")
