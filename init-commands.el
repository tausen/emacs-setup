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

(defun insert-php-comment ()
  (interactive)
  (insert "/**
     * Short description.
     * Longer description.
     *
     * @param type $param description of param
     * @return type description of return value
     */"))
(global-set-key (kbd "C-M-,") 'insert-php-comment)

;; EXAMPLE:
(defun insert-this ()
  (interactive)
  (insert "$this->"))


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
