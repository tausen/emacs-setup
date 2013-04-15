
; auto-complete
(add-to-list 'load-path "~/.emacs.d/lib/auto-complete")

;; emacs starter kit
(add-to-list 'load-path "~/.emacs.d/lib/")
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

; info+ - what does this do?
;(eval-after-load "info" '(require 'info+))

;; zenburn theme
(add-to-list 'load-path "~/.emacs.d/lib/color-theme-6.6.0/")
(require 'color-theme)
(load-theme 'zenburn)  ;; requires that zenburn.el is in your load path
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-zenburn)))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(initial-buffer-choice t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

; MAT: line numbers, etc
;; Show line-number in the mode line
(line-number-mode 1)
;; Show column-number in the mode line
(column-number-mode 1)
;; Dont split words across lines
(global-visual-line-mode t)
;; Set the fill column 
;(setq-default fill-column 72)
;; Show line numbers left of each line
(global-linum-mode t)

;; disable auto-fill behaviour
(setq auto-fill-mode -1)
(setq-default fill-column 99999)
(setq fill-column 99999)

;; bind return to newline and indent (turn on autoindentation)
(define-key global-map (kbd "RET") 'newline-and-indent)

;; ===== Set standard indent ====
(setq standard-indent 4)

;; ===== Turn off tab character =====
;; Emacs normally uses both tabs and spaces to indent lines. If you
;; prefer, all indentation can be made from spaces only. To request this,
;; set `indent-tabs-mode' to `nil'. This is a per-buffer variable;
;; altering the variable affects only the current buffer, but it can be
;; disabled for all buffers.
;; Use (setq ...) to set value locally to a buffer
;; Use (setq-default ...) to set value globally 
(setq-default indent-tabs-mode nil) 

;; switch between windows hotkeys
(global-set-key [M-left] 'windmove-left)          ; move to left windnow
(global-set-key [M-right] 'windmove-right)        ; move to right window
(global-set-key [M-up] 'windmove-up)              ; move to upper window
(global-set-key [M-down] 'windmove-down)          ; move to downer window

; dired+
(add-to-list 'load-path "~/.emacs.d/libs")
(require 'dired+)

; dired-details-hide
(require 'dired-details)
(dired-details-install)

;; dired order directories first
(defun sof/dired-sort ()
  "Dired sort hook to list directories first."
  (save-excursion
   (let (buffer-read-only)
     (forward-line 2) ;; beyond dir. header  
     (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max))))
  (and (featurep 'xemacs)
       (fboundp 'dired-insert-set-properties)
       (dired-insert-set-properties (point-min) (point-max)))
  (set-buffer-modified-p nil))

 (add-hook 'dired-after-readin-hook 'sof/dired-sort)

;; dired hide hidden files
(require 'dired-x)
(setq dired-omit-files "^\\...+$")
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1)))

;; ^ in dired mode use same buffer, use a to use same buffer when
;; opening selected dir, too
(add-hook 'dired-mode-hook
 (lambda ()
  (define-key dired-mode-map (kbd "^")
    (lambda () (interactive) (find-alternate-file "..")))
  ; was dired-up-directory
 ))

;; set-frame-width-interactive
(defun set-frame-width-interactive (arg)
   (interactive "p")
   (set-frame-width (selected-frame) arg))

;; dired remote (tramp) default ssh
(setq tramp-default-method "ssh")

;; ;; load nxhtml mode
;; ;(load "~/.emacs.d/libs/nxhtml/autostart.el")
; using php-mode improved instead... nxhtml is buggy
; below line should not be neccessary because libs is added to load path
;(load "~/.emacs.d/libs/php-mode-improved.el")
(require 'php-mode)
;; ;; regular php mode
;; (load "~/.emacs.d/libs/php-mode.el")
;; (require 'php-mode)

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

;; completely disable flyspell
(eval-after-load "flyspell"
  '(defun flyspell-mode (&optional arg)))

;; comment/uncomment regions hotkey
(global-set-key (kbd "M-_") 'comment-region)
(global-set-key (kbd "M-:") 'uncomment-region)

;; indent hotkey
(global-set-key (kbd "M-M") 'indent-region)

;; navigate up/down line-by-line hotkeys
(global-set-key (kbd "C-.") 'scroll-up-line)
(global-set-key (kbd "C-,") 'scroll-down-line)

;; replace double blank lines with single blank line
(defun single-lines-only ()
  "replace multiple blank lines with a single one"
  (interactive)
  (goto-char (point-min))
  (while (re-search-forward "\\(^\\s-*$\\)\n" nil t)
    (replace-match "\n")
    (forward-char 1)))

;; duplicate line hotkey
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)
(global-set-key (kbd "C-c C-d") 'duplicate-line)

;; delete line without putting in kill ring hotkey
(defun delete-line (&optional arg)
  (interactive "P")
  (flet ((kill-region (begin end)
                      (delete-region begin end)))
    (kill-line arg)))
(global-set-key [(control shift ?k)] 'delete-line) 

;; toggle truncate lines hotkey
(global-set-key (kbd "<f6>") 'toggle-truncate-lines)

;; bash autocompletion in emacs shell
(require 'bash-completion)
(bash-completion-setup)

;; auto-complete
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-1.4")
(require 'auto-complete)
;(global-auto-complete-mode 1) ; (uncomment to enable by default)

;; bind F5 to recompile (use M-x compile first!)
(global-set-key (kbd "<f5>") 'recompile)

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

;; breadcrumbs easier bookmarks
(require 'breadcrumb)
(global-set-key [(meta i)]              'bc-set)            ;; Shift-SPACE for set bookmark
(global-set-key [(meta p)]              'bc-local-previous) ;; M-j for jump to previous
(global-set-key [(meta n)]              'bc-local-next)     ;; Shift-M-j for jump to next
(global-set-key [(control c)(j)]        'bc-goto-current)   ;; C-c j for jump to current bookmark
(global-set-key [(control x)(meta j)]   'bc-list)           ;; C-x M-j for the bookmark menu list
(global-set-key [(meta c)]              'bc-clear)          ;; M-c to clear bookmarks
; also bc-previous, bc-next (can also jump between buffers)

;; indent comment to same column as previous line comment
(global-set-key (kbd "C-<tab>") 'indent-for-comment)

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
;; dont scroll as much with M-v and C-v
(setq next-screen-context-lines 10)
;; nicer scrolling behaviour
;(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)

(put 'dired-find-alternate-file 'disabled nil)


; (global-set-key (kbd "M-<up>") (lambda () (interactive) (move-line -1)))

;; auto scroll compilation window
(setq compilation-auto-scroll t)

;; snippets
;(require 'yasnippet-bundle)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; dired-fixups.el --- fixups for dired mode

;; Author: Dino Chiesa
;; Created: Sat, 31 Mar 2012  10:31
;; Version: 0.1
;;

(require 'ls-lisp)

    ;; (defun ls-lisp-format-time (file-attr time-index now)
    ;;   "################")

(defun ls-lisp-format-file-size (file-size human-readable)
  "This is a redefinition of the function from `dired.el'. This
fixes the formatting of file sizes in dired mode, to support very
large files. Without this change, dired supports 8 digits max,
which is up to 10gb.  Some files are larger than that.
"
  (if (or (not human-readable)
          (< file-size 1024))
      (format (if (floatp file-size) " %11.0f" " %11d") file-size)
    (do ((file-size (/ file-size 1024.0) (/ file-size 1024.0))
         ;; kilo, mega, giga, tera, peta, exa
         (post-fixes (list "k" "M" "G" "T" "P" "E") (cdr post-fixes)))
        ((< file-size 1024) (format " %10.0f%s"  file-size (car post-fixes))))))


(defun dired-sort-toggle ()
  "This is a redefinition of the fn from dired.el. Normally,
dired sorts on either name or time, and you can swap between them
with the s key.  This function one sets sorting on name, size,
time, and extension. Cycling works the same.
"
  (setq dired-actual-switches
        (let (case-fold-search)
          (cond
           ((string-match " " dired-actual-switches) ;; contains a space
            ;; New toggle scheme: add/remove a trailing " -t" " -S",
            ;; or " -U"
            ;; -t = sort by time (date)
            ;; -S = sort by size
            ;; -X = sort by extension

            (cond

             ((string-match " -t\\'" dired-actual-switches)
              (concat
               (substring dired-actual-switches 0 (match-beginning 0))
               " -X"))

             ((string-match " -X\\'" dired-actual-switches)
              (concat
               (substring dired-actual-switches 0 (match-beginning 0))
               " -S"))

             ((string-match " -S\\'" dired-actual-switches)
              (substring dired-actual-switches 0 (match-beginning 0)))

             (t
              (concat dired-actual-switches " -t"))))

           (t
            ;; old toggle scheme: look for a sorting switch, one of [tUXS]
            ;; and switch between them. Assume there is only ONE present.
            (let* ((old-sorting-switch
                    (if (string-match (concat "[t" dired-ls-sorting-switches "]")
                                      dired-actual-switches)
                        (substring dired-actual-switches (match-beginning 0)
                                   (match-end 0))
                      ""))

                   (new-sorting-switch
                    (cond
                     ((string= old-sorting-switch "t") "X")
                     ((string= old-sorting-switch "X") "S")
                     ((string= old-sorting-switch "S") "")
                     (t "t"))))
              (concat
               "-l"
               ;; strip -l and any sorting switches
               (dired-replace-in-string (concat "[-lt"
                                                dired-ls-sorting-switches "]")
                                        ""
                                        dired-actual-switches)
               new-sorting-switch))))))

  (dired-sort-set-modeline)
  (revert-buffer))


(defun dired-sort-set-modeline ()
 "This is a redefinition of the fn from `dired.el'. This one
properly provides the modeline in dired mode, supporting the new
search modes defined in the new `dired-sort-toggle'.
"
  ;; Set modeline display according to dired-actual-switches.
  ;; Modeline display of "by name" or "by date" guarantees the user a
  ;; match with the corresponding regexps.  Non-matching switches are
  ;; shown literally.
  (when (eq major-mode 'dired-mode)
    (setq mode-name
          (let (case-fold-search)
            (cond ((string-match "^-[^t]*t[^t]*$" dired-actual-switches)
                   "Dired by time")
                  ((string-match "^-[^X]*X[^X]*$" dired-actual-switches)
                   "Dired by ext")
                  ((string-match "^-[^S]*S[^S]*$" dired-actual-switches)
                   "Dired by sz")
                  ((string-match "^-[^SXUt]*$" dired-actual-switches)
                   "Dired by name")
                  (t
                   (concat "Dired " dired-actual-switches)))))
    (force-mode-line-update)))


(provide 'dired-fixups)

;;; dired-fixups.el ends here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



