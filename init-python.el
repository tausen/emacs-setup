;; Fancy python stuffs
; first: sudo apt-get install pyflakes pymacs

;(load-file "~/.emacs.d/lib/emacs-for-python/epy-init.el")

;; To manually specify what to load, do this:
;(add-to-list 'load-path "~/.emacs.d/lib/emacs-for-python/") ;; tell where to load the various files
;(require 'epy-setup)      ;; It will setup other loads, it is required!
;(require 'epy-python)     ;; If you want the python facilities [optional]
;(require 'epy-completion) ;; If you want the autocompletion settings [optional]
;(require 'epy-editing)    ;; For configurations related to editing [optional]
;(require 'epy-bindings)   ;; For my suggested keybindings [optional]
;(require 'epy-nose)       ;; For nose integration

;(setq skeleton-pair nil) ; disable the auto-close parenthesis from emacs-for-python

;; Hmm, something (probably emacs-for-python) overwrote C-o (insert line below point)
;; lets go ahead and redefine that one.
;(define-key global-map (kbd "C-o") 'open-line)

;; Not quite as fancy python stuffs
(add-to-list 'load-path "~/.emacs.d/lib/python/") 
(require 'python)

(setq ein:console-args '("--profile" "default"))
(require 'ein)

;; Needed for jedi to function properly
(add-to-list 'load-path "~/.emacs.d/lib/popup/")
(require 'popup)

;; Epic python auto completion
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'auto-complete-mode) ; ensure auto-complete-mode is on
(add-hook 'python-mode-hook 'jedi:ac-setup)
(setq jedi:setup-keys t)                      ; optional
(setq jedi:complete-on-dot t)                 ; optional
