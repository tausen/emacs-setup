;; breadcrumbs easier bookmarks
(load "~/.emacs.d/lib/breadcrumb.el")
(require 'breadcrumb)
(global-set-key (kbd "M-I")   'bc-set)            ;; M-I for set bookmark
(global-set-key (kbd "M-P")   'bc-local-previous) ;; M-P for jump to previous (local)
(global-set-key (kbd "M-N")   'bc-local-next)     ;; M-N for jump to next (local)
(global-set-key (kbd "M-L")   'bc-list)           ;; M-L for list of bookmarks
(global-set-key (kbd "C-c j") 'bc-goto-current)   ;; C-c j for jump to current bookmark
(global-set-key (kbd "M-C")   'bc-clear)          ;; M-C to clear bookmarks
; see also bc-previous, bc-next (can also jump between buffers)
