(add-to-list 'load-path "~/.emacs.d/lib/god-mode")
(require 'god-mode)

(global-set-key (kbd "C-x C-1") 'delete-other-windows)
(global-set-key (kbd "C-x C-2") 'split-window-below)
(global-set-key (kbd "C-x C-3") 'split-window-right)
(global-set-key (kbd "C-x C-0") 'delete-window)
(global-set-key (kbd "C-x C-{") 'shrink-window-horizontally)
(global-set-key (kbd "C-x C-}") 'enlarge-window-horizontally)
(global-set-key (kbd "C-x C-[") 'shrink-window)
(global-set-key (kbd "C-x C-]") 'enlarge-window)
(global-set-key (kbd "C-x C-5 C-0") 'delete-frame)
(global-set-key (kbd "C-x C-#") 'server-edit)

;; toggle god-mode while doing isearch, e.g.
;; do s something <tab> s s s instead of s something C-s C-s C-s
(require 'god-mode-isearch)
(define-key isearch-mode-map (kbd "<tab>") 'god-mode-isearch-activate)
(define-key isearch-mode-map "\t" 'god-mode-isearch-activate) ;; tab in nowindow
(define-key god-mode-isearch-map (kbd "<tab>") 'god-mode-isearch-disable)
(define-key god-mode-isearch-map "\t" 'god-mode-isearch-disable) ;; tab in nowindow

;; god-mode projectile hotkeys
(global-set-key (kbd "C-c C-p C-c") 'projectile-compile-project)
(global-set-key (kbd "C-c C-p C-f") 'projectile-find-file)
(global-set-key (kbd "C-c C-p C-R") 'projectile-regenerate-tags)

(define-key god-local-mode-map (kbd "z") 'repeat)
(define-key god-local-mode-map (kbd "i") 'god-mode-all)

;; Bind ALL the keys
(global-set-key (kbd "<escape>") 'god-or-newline)
(global-set-key (kbd "<RET>") 'god-or-newline) ;; really bad when pasting into nowindow
(global-set-key (kbd "<home>") 'god-or-newline)
(global-set-key (kbd "<f12>") 'god-or-newline)
(add-hook 'plain-tex-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-or-newline)))
(add-hook 'LaTeX-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-or-newline)))
(add-hook 'org-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-or-newline)))
(add-hook 'js2-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-or-newline)))
(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-or-newline)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-or-newline)))
(add-hook 'emacs-lisp-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-or-newline)))
(add-hook 'web-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-or-newline)))
(add-hook 'css-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-or-newline)))
(add-hook 'markdown-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-or-newline)))
(add-hook 'inferior-python-mode-hook (lambda () (local-set-key (kbd "<f12>") 'god-or-newline)))
(add-hook 'table-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-or-newline)))
(add-hook 'matlab-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-or-newline)))

;; In vhdl-mode, space is bound to vhdl electric space, 
;; so godmode SPC doesn't set mark - this fixes it
(add-hook 'vhdl-mode-hook (lambda () (define-key god-local-mode-map (kbd "<SPC>") 'set-mark-command)))
;; this may be a bad idea
(add-hook 'vhdl-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-or-newline)))
(add-hook 'verilog-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-or-newline)))

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
(add-to-list 'god-exempt-major-modes 'magit-mode)
(add-to-list 'god-exempt-major-modes 'org-agenda-mode)
(add-to-list 'god-exempt-major-modes 'calc-mode)
(add-to-list 'god-exempt-major-modes 'ibuffer-mode)
(add-to-list 'god-exempt-major-modes 'doc-view-mode)
;; (add-to-list 'god-exempt-major-modes 'inferior-python-mode)

;; Remove something from exempt major modes like this:
;; (setq god-exempt-major-modes (remove 'name-of-some-mode god-exempt-major-modes))

;; could be used... obviously change f9 to something else
;(define-key key-translation-map (kbd "<f9>") 'event-apply-control-modifier)

;; (defun c/god-mode-update-cursor ()
;;   (let ((limited-colors-p (> 257 (length (defined-colors)))))
;;     (cond (god-local-mode (progn
;;                             (set-face-background 'mode-line (if limited-colors-p "blue4" "#8b1a1a"))
;;                             (set-face-background 'mode-line-inactive (if limited-colors-p "gray25" "#404040"))))
;;           (t (progn
;;                (set-face-background 'mode-line (if limited-colors-p "gray15" "#262626"))
;;                (set-face-background 'mode-line-inactive (if limited-colors-p "gray25" "#404040")))))))

;; this is proably a bad idea! -- keep god mode enabled in ALL the modes
;; (setq god-exempt-predicates nil)
;; (setq god-exempt-predicates '(god-exempt-mode-p god-comint-mode-p god-view-mode-p god-special-mode-p))
(setq god-exempt-predicates '(god-exempt-mode-p god-view-mode-p god-special-mode-p))

;; only works with x11
(defun my-update-cursor ()
  (setq cursor-type (if (or god-local-mode buffer-read-only)
                        'bar
                      'box)))
(add-hook 'god-mode-enabled-hook 'my-update-cursor)
(add-hook 'god-mode-disabled-hook 'my-update-cursor)

;; indicate whether god-mode is on with blue mode-line background
;; always works (if not in limited colors term..)
;; (defun c/god-mode-update-cursor ()
;;   (cond (god-local-mode (progn (set-face-background 'mode-line "blue4")))
;;         (t (progn (set-face-background 'mode-line "gray15")))))
(defun c/god-mode-update-cursor ()
  (cond (god-local-mode (progn (set-face-background 'mode-line "deep sky blue")))
        (t (progn (set-face-background 'mode-line "gray80")))))
(add-hook 'god-mode-enabled-hook 'c/god-mode-update-cursor)
(add-hook 'god-mode-disabled-hook 'c/god-mode-update-cursor)


;; toggle RET between god-mode-all and newline with f7
;; note: Due to the hooks binding RET to god-or-newline, RET is in most modes not actually
;;       bound back to newline. god-or-newline handles this by checking the god-bound-to-ret
;;       flag.
(setq god-bound-to-ret t)

(defun god-or-newline ()
  (interactive)
  (if god-bound-to-ret (god-mode-all) (newline)))

(defun bind-ret-god ()
  (cond  ;; tries each condition until one succeeds

   (god-bound-to-ret (global-set-key (kbd "<RET>") 'newline)
                     (setq god-bound-to-ret nil)
                     (message "RET bound to newline") )

   (t (global-set-key (kbd "<RET>") 'god-or-newline)
      (setq god-bound-to-ret t)
      (message "RET bound to god-mode-all") )
   
   ))

(global-set-key (kbd "<f7>") (lambda () (interactive) (bind-ret-god)))

;; goto-line that I can bind to another key
(defun my-goto-line (line)
  (interactive "nGoto line: ")
  (goto-char (point-min))
  (forward-line (1- line)))

;; goto line with C-L or just L in god-mode
(global-set-key (kbd "C-S-l") 'my-goto-line)
(define-key god-local-mode-map (kbd "L") 'my-goto-line)
