(setq elscreen-prefix-key (kbd "C-#"))
(define-key org-mode-map (kbd "C-#") nil) ;; key already in use in org-mode
(define-key c-mode-map (kbd "#") nil) ;; key already in use in c-mode

;; load up
(add-to-list 'load-path "~/.emacs.d/lib/elscreen")
(load "~/.emacs.d/lib/elscreen/elscreen.el")
(elscreen-start)

;; god-mode compatibility
(global-set-key (kbd "C-# C-0") (lambda () (interactive) (elscreen-goto 0)))
(global-set-key (kbd "C-# C-1") (lambda () (interactive) (elscreen-goto 1)))
(global-set-key (kbd "C-# C-2") (lambda () (interactive) (elscreen-goto 2)))
(global-set-key (kbd "C-# C-3") (lambda () (interactive) (elscreen-goto 3)))
(global-set-key (kbd "C-# C-4") (lambda () (interactive) (elscreen-goto 4)))
(global-set-key (kbd "C-# C-5") (lambda () (interactive) (elscreen-goto 5)))
(global-set-key (kbd "C-# C-6") (lambda () (interactive) (elscreen-goto 6)))
(global-set-key (kbd "C-# C-7") (lambda () (interactive) (elscreen-goto 7)))
(global-set-key (kbd "C-# C-8") (lambda () (interactive) (elscreen-goto 8)))
(global-set-key (kbd "C-# C-9") (lambda () (interactive) (elscreen-goto 9)))
(global-set-key (kbd "C-# C-n") (lambda () (interactive) (elscreen-next)))
(global-set-key (kbd "C-# C-p") (lambda () (interactive) (elscreen-previous)))
(global-set-key (kbd "C-# C-c") (lambda () (interactive) (elscreen-create)))
(global-set-key (kbd "C-# C-k") (lambda () (interactive) (elscreen-kill)))
(global-set-key (kbd "C-# C-a") (lambda () (interactive) (elscreen-toggle)))

;; looks
(setq elscreen-display-screen-number nil)
(setq elscreen-tab-display-control nil)
(setq elscreen-tab-display-kill-screen nil)

(set-face-attribute  'elscreen-tab-background-face
                     nil
                     :foreground "white"
                     :background "gray23")

(set-face-attribute  'elscreen-tab-current-screen-face
                     nil
                     :foreground "white"
                     :background "gray17")

(set-face-attribute  'elscreen-tab-other-screen-face
                     nil
                     :foreground "gray60"
                     :background "gray23")
