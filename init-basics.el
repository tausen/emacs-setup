;; Show line-number in the mode line
(line-number-mode 1)
;; Show column-number in the mode line
(column-number-mode 1)

; font size
(set-face-attribute 'default nil :height 120)

; basic behavior stuff
(global-visual-line-mode t)
(setq auto-fill-mode -1)
(setq-default fill-column 99999999)
(setq fill-column 99999999)
(setq-default comment-column 0)
(setq visible-bell nil)
;; allow selection deletion
(delete-selection-mode t)
;; turn off the menu bar
(menu-bar-mode 0)
(tool-bar-mode 0)
;; have emacs scroll line-by-line
(setq scroll-step 1)
;; set mouse scroll to line by line
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
;; nicer mouse scroll
(setq mouse-wheel-progressive-speed nil)
;; dont scroll as much with M-v and C-v
(setq next-screen-context-lines 10)
;; nicer scrolling behaviour
(setq auto-window-vscroll nil)
;; highlight parens
(show-paren-mode t)
;; indent after newline in c-like modes
(electric-indent-mode -1)
;; remember last place in file
(save-place-mode 1)
;; disable scrollbar
(toggle-scroll-bar -1)

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
(add-hook 'ibuffer-mode-hook (lambda () (setq truncate-lines t))) ; truncate lines in ibuffer mode
(add-hook 'proced-mode-hook (lambda () (setq truncate-lines t))) ; truncate lines in proced mode

;; auto scroll compilation window
(setq compilation-auto-scroll t)
(setq compilation-scroll-output t)

;; Allow copying to system clipboard
(setq x-select-enable-clipboard t)

;; Disable blinking cursor
(blink-cursor-mode 0)

; y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

; backup behavior
(setq backup-directory-alist `(("." . "~/.emacs_backups")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;; multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-c C-<") 'mc/edit-lines) 
(global-set-key (kbd "C-c M-<") 'mc/edit-lines) 
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C->") 'mc/mark-all-like-this)

;; Emacs builtin move between windows. Default keys are shift and arrow keys
(windmove-default-keybindings)

(global-set-key (kbd "C-x C-o") 'other-window)

;; Nice line wrap (virtual indent)
(require 'adaptive-wrap)
;; enable for all programming modes
(add-hook 'prog-mode-hook (lambda () (adaptive-wrap-prefix-mode)))

;; Use org-indent mode when in org mode
(add-hook 'org-mode-hook (lambda () (org-indent-mode)))

(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))
(global-set-key (kbd "M-'") 'comment-or-uncomment-region-or-line)

;; delete pair of parens, ..
(global-set-key (kbd "C-x p") 'delete-pair)

;; go to next/previous match (errors, grep, ..)
(global-set-key (kbd "C-x C-n") 'next-error)
(global-set-key (kbd "C-x C-p") 'previous-error)

;; http://www.emacswiki.org/emacs/InsertFileName
(defun my-insert-file-name (filename &optional args)
  "Insert name of file FILENAME into buffer after point.
  
  Prefixed with \\[universal-argument], expand the file name to
  its fully canocalized path.  See `expand-file-name'.
  
  Prefixed with \\[negative-argument], use relative path to file
  name from current directory, `default-directory'.  See
  `file-relative-name'.
  
  The default with no prefix is to insert the file name exactly as
  it appears in the minibuffer prompt."
  ;; Based on insert-file in Emacs -- ashawley 20080926
  (interactive "*fInsert file name: \nP")
  (cond ((eq '- args)
         (insert (file-relative-name filename)))
        ((not (null args))
         (insert (expand-file-name filename)))
        (t
         (insert filename))))
;; C-u C-c i  expand file name to full path
;; M-- C-c i  relative path
(global-set-key (kbd "C-c i") 'my-insert-file-name)

;; associate some file types with external applications
(require 'openwith)
(setq openwith-associations '(("\\.eps\\'" "qpdfview" ("--unique" file))))
;; used to have qpdfview for pdfs - now using pdf-tools
;;("\\.pdf\\'" "qpdfview" ("--unique" file))
(openwith-mode t)

;; I'm getting real tired of your shit, mr window split
(setq split-height-threshold nil)
(setq split-width-threshold 160)

;; Scroll screen and point
(defun scroll-next-line (nlines)
  "Scroll pointer and screen down"
  (interactive)
  (scroll-up-line nlines)
  (next-line nlines))
(defun scroll-previous-line (nlines)
  "Scroll pointer and screen up"
  (interactive)
  (scroll-down-line nlines)
  (previous-line nlines))

(defun swap-parens ()
  (interactive)
  (cond ((looking-at "\\s(")
         (swap-parens-at-points (point) (save-excursion (forward-sexp) (point))))
        ((and (> (point) 1) (save-excursion (forward-char -1) (looking-at "\\s)")))
         (swap-parens-at-points (save-excursion (forward-sexp -1) (point)) (point)))
        ((message "Not at a paren"))))
(global-set-key (kbd "C-c s p") 'swap-parens)

(global-set-key (kbd "C-x \\") 'align-regexp)

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
(global-set-key (kbd "C-c C-,") 'create-cursor)
(global-set-key (kbd "C-c C-.") 'multiple-cursors-mode)

(when (fboundp 'winner-mode)
  (winner-mode 1))
