;; switch between windows hotkeys
(global-set-key [M-S-left] 'windmove-left)          ; move to left windnow
(global-set-key [M-S-right] 'windmove-right)        ; move to right window
(global-set-key [M-S-up] 'windmove-up)              ; move to upper window
(global-set-key [M-S-down] 'windmove-down)          ; move to downer window

;; comment/uncomment regions hotkey
(global-set-key (kbd "M-_") 'comment-region)
(global-set-key (kbd "M-:") 'uncomment-region)

;; indent hotkey
(global-set-key (kbd "M-M") 'indent-region)

;; bind F5 to recompile (use M-x compile first!)
(global-set-key (kbd "<f5>") 'recompile)

;; proper beginning/end of line, kill line (rather than end-of-visual-line etc.)
(global-set-key (kbd "C-e") 'end-of-line)
(global-set-key (kbd "C-a") 'beginning-of-line)
(global-set-key (kbd "C-k") 'kill-line) ;; this one doesnt work for some reason??

;; breadcrumbs easier bookmarks
(require 'breadcrumb)
(global-set-key [(meta I)]              'bc-set)            ;; Shift-SPACE for set bookmark
(global-set-key [(meta P)]              'bc-local-previous) ;; M-j for jump to previous
(global-set-key [(meta N)]              'bc-local-next)     ;; Shift-M-j for jump to next
(global-set-key [(control c)(j)]        'bc-goto-current)   ;; C-c j for jump to current bookmark
(global-set-key [(control x)(meta j)]   'bc-list)           ;; C-x M-j for the bookmark menu list
(global-set-key [(meta C)]              'bc-clear)          ;; M-c to clear bookmarks
; also bc-previous, bc-next (can also jump between buffers)

;; indent comment to same column as previous line comment
(global-set-key (kbd "C-<tab>") 'indent-for-comment)

;; bind tab to proper indent globally
;(global-set-key (kbd "C-i") 'c-indent-line-or-region)

(global-set-key (kbd "C-x \\") 'align-regexp)

(global-set-key (kbd "C-x t") 'insert-this)
(global-set-key (kbd "C-x ½") 'winsav-rotate) ; flip buffers
(global-set-key (kbd "C-x 9") 'winsav-rotate) ; flip buffers

;; mode toggle hotkeys
(define-key global-map (kbd "C-c m a") 'auto-complete-mode)
(define-key global-map (kbd "C-c m p") 'autopair-mode)
(define-key global-map (kbd "C-c m f") 'flyspell-mode)
(define-key global-map (kbd "C-c m s") 'semantic-mode)

;; flyspell hotkeys
(define-key global-map (kbd "C-c f b") 'flyspell-buffer)

;; magit
(global-set-key (kbd "C-x g") 'magit-status)

;; ipython notebook
(global-set-key (kbd "C-c e s") 'start-ipython-notebook)
(global-set-key (kbd "C-c e K") 'kill-ipython)
(global-set-key (kbd "C-c e o") 'ein:notebooklist-open)
(global-set-key (kbd "C-c e k") 'ein:notebook-kill-all-buffers)
(global-set-key (kbd "C-c e c") 'ein:connect-to-notebook-command)
(global-set-key (kbd "C-c e a") 'ein:notebook-execute-autoexec-cells)

;; Some scrolling hotkeys
(global-set-key (kbd "M-p") (lambda () (interactive) (scroll-down 5)))
(global-set-key (kbd "M-n") (lambda () (interactive) (scroll-up 5)))
(global-set-key (kbd "s-p") (lambda () (interactive) (scroll-previous-line 1)))
(global-set-key (kbd "s-n") (lambda () (interactive) (scroll-next-line 1)))
(global-set-key (kbd "M-s-p") (lambda () (interactive) (scroll-previous-line 5)))
(global-set-key (kbd "M-s-n") (lambda () (interactive) (scroll-next-line 5)))

