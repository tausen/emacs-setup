;; ===== Define which-mode ====
; returns the major mode of a buffer
(defun which-mode ()
  (interactive)
  (message "%s" major-mode))

;; set-frame-width-interactive
(defun set-frame-width-interactive (arg)
   (interactive "p")
   (set-frame-width (selected-frame) arg))

;; mark word under cursor
;; http://www.emacswiki.org/emacs/MarkCommands
(defun my-mark-current-word (&optional arg allow-extend)
  "Put point at beginning of current word, set mark at end."
  (interactive "p\np")
  (setq arg (if arg arg 1))
  (if (and allow-extend
           (or (and (eq last-command this-command) (mark t))
               (region-active-p)))
      (set-mark
       (save-excursion
         (when (< (mark) (point))
           (setq arg (- arg)))
         (goto-char (mark))
         (forward-word arg)
         (point)))
    (let ((wbounds (bounds-of-thing-at-point 'word)))
      (unless (consp wbounds)
        (error "No word at point"))
      (if (>= arg 0)
          (goto-char (car wbounds))
        (goto-char (cdr wbounds)))
      (push-mark (save-excursion
                   (forward-word arg)
                   (point)))
      (activate-mark))))
(define-key global-map (kbd "C-x w") 'my-mark-current-word)
(define-key global-map (kbd "C-M-w") 'my-mark-current-word)

;; delete whitespace from point to word
(defun whack-whitespace (arg)
  "Delete all white space from point to the next word.  With prefix ARG
    delete across newlines as well.  The only danger in this is that you
    don't have to actually be at the end of a word to make it work.  It
    skips over to the next whitespace and then whacks it all to the next
    word."
  (interactive "P")
  (let ((regexp (if arg "[ \t\n]+" "[ \t]+")))
    (re-search-forward regexp nil t)
    (replace-match "" nil nil)))
(global-set-key (kbd "M-K") 'whack-whitespace)

;; delete all trailing whitespace in buffer
(defun my-delete-trailing-whitespace ()
  "..."
  (interactive)
  (delete-trailing-whitespace)
  (message "Deleted all trailing whitespace"))
(global-set-key (kbd "C-c w") 'my-delete-trailing-whitespace)

;; toggle fullscreen
(defun toggle-fullscreen ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))

(global-set-key [f11] 'toggle-fullscreen)

(defun start-ipython-notebook ()
  "Start ipython notebook server"
  (interactive)
  (async-shell-command "ipython notebook --port=8888 --no-browser --ip=*"))

(defun kill-ipython ()
  "Kill all ipython processes"
  (interactive)
  (shell-command "killall ipython"))

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

;; http://www.emacswiki.org/emacs/ToggleWindowSplit
(defun window-toggle-split-direction ()
  "Switch window split from horizontally to vertically, or vice versa.

i.e. change right window to bottom, or change bottom window to right."
  (interactive)
  (require 'windmove)
  (let ((done))
    (dolist (dirs '((right . down) (down . right)))
      (unless done
        (let* ((win (selected-window))
               (nextdir (car dirs))
               (neighbour-dir (cdr dirs))
               (next-win (windmove-find-other-window nextdir win))
               (neighbour1 (windmove-find-other-window neighbour-dir win))
               (neighbour2 (if next-win (with-selected-window next-win
                                          (windmove-find-other-window neighbour-dir next-win)))))
          ;;(message "win: %s\nnext-win: %s\nneighbour1: %s\nneighbour2:%s" win next-win neighbour1 neighbour2)
          (setq done (and (eq neighbour1 neighbour2)
                          (not (eq (minibuffer-window) next-win))))
          (if done
              (let* ((other-buf (window-buffer next-win)))
                (delete-window next-win)
                (if (eq nextdir 'right)
                    (split-window-vertically)
                  (split-window-horizontally))
                (set-window-buffer (windmove-find-other-window neighbour-dir) other-buf))))))))

(global-set-key (kbd "C-x C-y") 'window-toggle-split-direction)

;; https://github.com/magnars/multiple-cursors.el/issues/44
(defun create-cursor ()
  (interactive)
  (mc/create-fake-cursor-at-point))

;; http://www.emacswiki.org/emacs/DictMode
(defun my-dictionary-search ()
  (interactive)
  (let ((word (current-word))
        (enable-recursive-minibuffers t)
        (val))
    (setq val (read-from-minibuffer
               (concat "Word"
                       (when word
                         (concat " (" word ")"))
                       ": ")))
    (dictionary-new-search
     (cons (cond
            ((and (equal val "") word)
             word)
            ((> (length val) 0)
             val)
            (t
             (error "No word to lookup")))
           dictionary-default-dictionary))))

;; Insert nicely formatted number with unit using math (for use in rest-mode)
(defun my-rest-insert-num (n u)
  "Insert number with unit"
  (interactive "sNumber: 
sUnit: ")
  (insert (format ":math:`%s\\text{\\,%s}`" n u)))
(add-hook 'rst-mode-hook (lambda () (local-set-key (kbd "C-c C-u") 'my-rest-insert-num)))

(defun my-rest-insert-range (n m u)
  "Insert number range with unit"
  (interactive "sFirst number: 
sSecond number: 
sUnit: ")
  (insert (format ":math:`%s\\text{-}%s\\text{\\,%s}`" n m u)))
(add-hook 'rst-mode-hook (lambda () (local-set-key (kbd "C-c C-i") 'my-rest-insert-range)))

;; Rotate page in doc-view-mode
;; http://stackoverflow.com/questions/2684547/rotate-document-in-emacs-doc-view-mode
(defun doc-view-rotate-current-page ()
  "Rotate the current page by 90 degrees.
Requires ImageMagick installation"
  (interactive)
  (when (eq major-mode 'doc-view-mode)
    ;; we are assuming current doc-view internals about cache-names
    (let ((file-name (expand-file-name (format "page-%d.png" (doc-view-current-page)) (doc-view-current-cache-dir))))
      ;; assume imagemagick is installed and rotate file in-place and redisplay buffer
      (call-process-shell-command "convert" nil nil nil "-rotate" "90" file-name file-name)
      (clear-image-cache)
      (doc-view-goto-page (doc-view-current-page)))))

(defun yank-to-other ()
  (interactive)
  (other-window 1)
  (yank)
  (newline-and-indent)
  (other-window -1))
(global-set-key (kbd "C-c C-y") 'yank-to-other)
;; http://stackoverflow.com/questions/14213173/swap-parentheses-and-square-brackets-in-emacs-paredit
(defvar swap-paren-pairs '("()" "[]"))
(defun swap-parens-at-points (b e)
  (let ((open-char (buffer-substring b (+ b 1)))
        (paren-pair-list (append swap-paren-pairs swap-paren-pairs)))
    (while paren-pair-list
      (if (eq (aref open-char 0) (aref (car paren-pair-list) 0))
          (save-excursion
            (setq to-replace (cadr paren-pair-list))
            (goto-char b)
            (delete-char 1)
            (insert (aref to-replace 0))
            (goto-char (- e 1))
            (delete-char 1)
            (insert (aref to-replace 1))
            (setq paren-pair-list nil))
        (setq paren-pair-list (cdr paren-pair-list))))))

(defun swap-parens ()
  (interactive)
  (cond ((looking-at "\\s(")
         (swap-parens-at-points (point) (save-excursion (forward-sexp) (point))))
        ((and (> (point) 1) (save-excursion (forward-char -1) (looking-at "\\s)")))
         (swap-parens-at-points (save-excursion (forward-sexp -1) (point)) (point)))
        ((message "Not at a paren"))))
(global-set-key (kbd "C-c s p") 'swap-parens)

;; run grep-find from projectile root directory, mostly stolen from function grep-find in grep.el
(defun my-projectile-grep-find (command-args)
  (interactive
   (progn
     (grep-compute-defaults)
     (if grep-find-command
         (let ((findopts (read-string "Find options: "))) 
           (list
            (read-shell-command "Run find (like this): " (concat "find " (projectile-project-root) " -type f " findopts " -print0 | xargs -0 -e grep -nH -e ") 'grep-find-history)))
       ;; No default was set
       (read-string
        "compile.el: No `grep-find-command' command available. Press RET.")
       (list nil))))
  (when command-args
    (let ((null-device nil))		; see grep
      (grep command-args))))
(global-set-key (kbd "C-c m p g") 'my-projectile-grep-find)
