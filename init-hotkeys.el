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

;; bind F5 to compile, C-u compile to customize compile command
(global-set-key (kbd "<f5>") 'compile)

;; regular beginning/end of line, kill line (rather than end-of-visual-line etc.)
;(global-set-key (kbd "C-e") 'end-of-visual-line)
;(global-set-key (kbd "C-a") 'beginning-of-visual-line)
;(global-set-key (kbd "C-k") 'kill-line) ;; this one doesnt work for some reason??

;; breadcrumbs easier bookmarks
(require 'breadcrumb)
(global-set-key (kbd "M-I")   'bc-set)            ;; M-I for set bookmark
(global-set-key (kbd "M-P")   'bc-local-previous) ;; M-P for jump to previous (local)
(global-set-key (kbd "M-N")   'bc-local-next)     ;; M-N for jump to next (local)
(global-set-key (kbd "M-L")   'bc-list)           ;; M-L for list of bookmarks
(global-set-key (kbd "C-c j") 'bc-goto-current)   ;; C-c j for jump to current bookmark
(global-set-key (kbd "M-C")   'bc-clear)          ;; M-C to clear bookmarks
; see also bc-previous, bc-next (can also jump between buffers)

;; indent comment to same column as previous line comment
(global-set-key (kbd "C-<tab>") 'indent-for-comment)

;; bind tab to proper indent globally
;(global-set-key (kbd "C-i") 'c-indent-line-or-region)

(global-set-key (kbd "C-x \\") 'align-regexp)

(global-set-key (kbd "C-x t") 'insert-this)
(global-set-key (kbd "C-x ½") 'window-toggle-split-direction)
(global-set-key (kbd "C-x 9") 'window-toggle-split-direction)

;; mode toggle hotkeys
(define-key global-map (kbd "C-c c t") 'auto-complete-mode)
(define-key global-map (kbd "C-c a t") 'autopair-mode)
(define-key global-map (kbd "C-c f t") 'flyspell-mode)
(define-key global-map (kbd "C-c s t") 'semantic-mode)

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
(global-set-key (kbd "C-s-p") (lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "C-s-n") (lambda () (interactive) (next-line 5)))
;; (global-set-key (kbd "M-P") (lambda () (interactive) (previous-line 5)))
;; (global-set-key (kbd "M-N") (lambda () (interactive) (next-line 5)))
;; (global-set-key (kbd "s-p") (lambda () (interactive) (scroll-previous-line 1)))
;; (global-set-key (kbd "s-n") (lambda () (interactive) (scroll-next-line 1)))
(global-set-key (kbd "M-s-p") (lambda () (interactive) (scroll-previous-line 5)))
(global-set-key (kbd "M-s-n") (lambda () (interactive) (scroll-next-line 5)))

;; multiple cursors
(global-unset-key (kbd "C-S-<mouse-1>"))
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
;; https://github.com/magnars/multiple-cursors.el/issues/44
(global-set-key (kbd "C-c C-,") 'create-cursor)
(global-set-key (kbd "C-c C-.") 'multiple-cursors-mode)

;; doc-view
;; bind shift-space to scroll down in doc-view mode (space scrolls up)
(add-hook 'doc-view-mode-hook (lambda () (local-set-key (kbd "S-SPC") 'doc-view-scroll-down-or-previous-page)))
;; bind M-r to rotate page (command in init-commands.el)
(add-hook 'doc-view-mode-hook (lambda () (local-set-key (kbd "M-r") 'doc-view-rotate-current-page)))

;; speedbar
(global-set-key (kbd "C-c b t") 'speedbar)  ; toggle speedbar

(add-hook 'makefile-gmake-mode-hook (lambda () (local-set-key (kbd "M-p") (lambda () (interactive) (scroll-down 5)))))
(add-hook 'makefile-gmake-mode-hook (lambda () (local-set-key (kbd "M-n") (lambda () (interactive) (scroll-up 5)))))
