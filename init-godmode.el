(add-to-list 'load-path "~/.emacs.d/lib/god-mode")
(require 'god-mode)

(defun my-update-cursor ()
  (setq cursor-type (if (or god-local-mode buffer-read-only)
                        'bar
                      'box)))

(add-hook 'god-mode-enabled-hook 'my-update-cursor)
(add-hook 'god-mode-disabled-hook 'my-update-cursor)

(global-set-key (kbd "C-x C-1") 'delete-other-windows)
(global-set-key (kbd "C-x C-2") 'split-window-below)
(global-set-key (kbd "C-x C-3") 'split-window-right)
(global-set-key (kbd "C-x C-0") 'delete-window)

(define-key god-local-mode-map (kbd "z") 'repeat)
(define-key god-local-mode-map (kbd "i") 'god-mode-all)

;; Bind ALL the keys
(global-set-key (kbd "<escape>") 'god-mode-all)
(global-set-key (kbd "<RET>") 'god-mode-all)
(add-hook 'LaTeX-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-mode-all)))
(add-hook 'org-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-mode-all)))

;; In vhdl-mode, space is bound to vhdl electric space, 
;; so godmode SPC doesn't set mark - this fixes it
(add-hook 'vhdl-mode-hook (lambda () (define-key god-local-mode-map (kbd "<SPC>") 'set-mark-command)))
;; this may be a bad idea
(add-hook 'vhdl-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-mode-all)))

;; Should do something like this...
;; (define-key god-local-mode-map (kbd "s-j") 'windwmove-down)
;; (define-key god-local-mode-map (kbd "s-k") 'windwmove-up)
;; (define-key god-local-mode-map (kbd "s-l") 'windwmove-left)
;; (define-key god-local-mode-map (kbd "s-h") 'windwmove-right)


;; (defun god-toggle-on-overwrite ()
;;   "Toggle god-mode on overwrite-mode."
;;   (if (bound-and-true-p overwrite-mode)
;;       (god-local-mode-pause)
;;     (god-local-mode-resume)))

;; (add-hook 'overwrite-mode-hook 'god-toggle-on-overwrite)

(add-to-list 'god-exempt-major-modes 'term-mode)
;; (add-to-list 'god-exempt-major-modes 'magit-mode)
;; (add-to-list 'god-exempt-major-modes 'inferior-python-mode)

;; Remove something from exempt major modes like this:
;; (setq god-exempt-major-modes (remove 'name-of-some-mode god-exempt-major-modes))

;; could be used... obviously change f9 to something else
;(define-key key-translation-map (kbd "<f9>") 'event-apply-control-modifier)
