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

