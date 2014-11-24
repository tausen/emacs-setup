
(add-to-list 'load-path "~/.emacs.d/lib/git-modes")
(add-to-list 'load-path "~/.emacs.d/lib/magit")
(eval-after-load 'info
  '(progn (info-initialize)
          (add-to-list 'Info-directory-list "~/.emacs.d/lib/magit/")))
(require 'magit)

(global-set-key (kbd "C-c C-g") 'magit-status)
; (magit-status-buffer-switch-function (quote switch-to-buffer))
; (magit-status-buffer-switch-function (quote pop-to-buffer))

(setenv "GIT_EDITOR" "emacsclient")
(setenv "EDITOR" "emacsclient")
