;; Dont split words across lines with exceptions
(global-visual-line-mode t)
;;(global-visual-line-mode nil)
;; (setq visual-disabled-modes-list
;;       '(term-mode eshell-mode wl-summary-mode compilation-mode erc-mode magit-status-mode))
;; (defun visual-line-on ()
;;   (unless (or (minibufferp) (member major-mode visual-disabled-modes-list))
;;     (visual-line-mode 1)))

;; Set the fill column 
;(setq-default fill-column 72)
;; Enable line numbers with exceptions (buffers with * in name don't have linum)
(global-linum-mode t)
(require 'linum-off)
;(global-linum-mode nil)

; linum spacing
;(setq linum-format "%d ")
;If you want a solid line separator, try something like this:
;(setq linum-format “%4d \u2502 “)

;; disable auto-fill behaviour
(setq auto-fill-mode -1)

;; set fill columns
(setq-default fill-column 99999999)
(setq fill-column 99999999)

;; don't use comment column by default
(setq-default comment-column 0)

;; highlight current line
(global-hl-line-mode 1)

;; bind return to newline and indent (turn on autoindentation)
(define-key global-map (kbd "RET") 'newline-and-indent)

;; ===== Set standard indent ====
(setq standard-indent 4)
(setq-default tab-width 4)

;; ===== Turn off tab character =====
;; Emacs normally uses both tabs and spaces to indent lines. If you
;; prefer, all indentation can be made from spaces only. To request this,
;; set `indent-tabs-mode' to `nil'. This is a per-buffer variable;
;; altering the variable affects only the current buffer, but it can be
;; disabled for all buffers.
;; Use (setq ...) to set value locally to a buffer
;; Use (setq-default ...) to set value globally 
(setq-default indent-tabs-mode nil) 

; fix php/C {'s, http://stackoverflow.com/questions/168621/php-mode-for-emacs
(setq c-default-style "bsd"
      c-basic-offset 4)

;; set automated backups dir
; Enable backup files.
;(setq make-backup-files t)
; Enable versioning with default values (keep five last versions, I think!)
;(setq version-control t)
; Save all backup file in this directory.
;(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/")))
(setq backup-directory-alist `(("." . "~/.emacs_backups")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;; ############################################
; From:
; http://paradox1x.org/2010/06/making-emacs-wi/
;; visible bell
(setq visible-bell nil)
;; allow selection deletion
(delete-selection-mode t)
;; make sure delete key is delete key
(global-set-key [delete] 'delete-char)
;; turn on the menu bar
(menu-bar-mode 1)
;; have emacs scroll line-by-line
(setq scroll-step 1)
;; ;; set color-theme
;; ;(color-theme-zenburn)
;; (load-theme 'zenburn t)
(defun my-zoom (n)
"Increase or decrease font size based upon argument"
(set-face-attribute 'default (selected-frame) :height
(+ (face-attribute 'default :height) (* (if (> n 0) 1 -1) 10))))
(global-set-key (kbd "C-+")      '(lambda nil (interactive) (my-zoom 1)))
(global-set-key [C-kp-add]       '(lambda nil (interactive) (my-zoom 1)))
(global-set-key (kbd "C--")      '(lambda nil (interactive) (my-zoom -1)))
(global-set-key [C-kp-subtract]  '(lambda nil (interactive) (my-zoom -1)))
(message "All done!")
;; ############################################

;; set mouse scroll to line by line
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
;; nicer mouse scroll
(setq mouse-wheel-progressive-speed nil)
;; smooth scrolling
;(require 'smooth-scrolling)
;(require 'smooth-scroll)
;(smooth-scroll-mode t)
;; dont scroll as much with M-v and C-v
(setq next-screen-context-lines 10)
;; nicer scrolling behaviour
;(setq scroll-step 1)
;(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)

(show-paren-mode t)

;; truncate lines 
(setq-default truncate-lines t) 
(global-set-key (kbd "<f6>") 'toggle-truncate-lines) ; bind f6 to toggle
(add-hook 'latex-mode-hook (lambda () (setq truncate-lines nil))) ; dont truncate in latex mode
(add-hook 'compilation-mode-hook (lambda () (setq truncate-lines t))) ; please truncate in compilation mode
(add-hook 'buffer-menu-mode-hook (lambda () (setq truncate-lines t))) ; please truncate in buffer menu
(add-hook 'c-mode-hook (lambda () (setq truncate-lines t))) ; please truncate in c-mode
(add-hook 'lisp-mode-hook (lambda () (setq truncate-lines t))) ; please truncate in lisp-mode
(add-hook 'term-mode-hook (lambda () (setq truncate-lines t))) ; truncate in ansi-term and similar
(add-hook 'diff-mode-hook (lambda () (setq truncate-lines t))) ; truncate lines in diff mode

;; auto scroll compilation window
(setq compilation-auto-scroll t)
(setq compilation-scroll-output t)

;; Align with spaces only
(defadvice align-regexp (around align-regexp-with-spaces)
  "Never use tabs for alignment."
  (let ((indent-tabs-mode nil))
    ad-do-it))
(ad-activate 'align-regexp)

;; Allow copying to system clipboard
(setq x-select-enable-clipboard t)

;; Disable blinking cursor
(blink-cursor-mode 0)

; y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)
