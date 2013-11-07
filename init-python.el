;; Python
; first: sudo apt-get install pyflakes pymacs
(require 'yasnippet)
(load-file "~/.emacs.d/lib/emacs-for-python/epy-init.el")
(setq skeleton-pair nil) ; disable the auto-close parenthesis from emacs-for-python

;; Hmm, something (probably emacs-for-python) overwrote C-o (insert line below point)
;; lets go ahead and redefine that one.
(define-key global-map (kbd "C-o") 'open-line)
