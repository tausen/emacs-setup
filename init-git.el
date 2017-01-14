(require 'magit)

(global-set-key (kbd "C-x g") 'magit-status)

(setenv "GIT_EDITOR" "emacsclient")
(setenv "EDITOR" "emacsclient")
