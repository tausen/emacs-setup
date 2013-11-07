;; improvements to ido-mode
(add-to-list 'load-path "~/.emacs.d/lib/ido-hacks/")
(add-to-list 'load-path "~/.emacs.d/lib/smex/")
(require 'ido)
(eval-when-compile
  (require 'cl))
;; https://github.com/nonsequitur/smex
(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                  ; when Smex is auto-initialized on its first run.
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

