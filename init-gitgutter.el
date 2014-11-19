;; load and configure git-gutter fringe plus
(add-to-list 'load-path "~/.emacs.d/lib/git-gutter-plus")
(add-to-list 'load-path "~/.emacs.d/lib/git-gutter-fringe-plus")

(require 'git-gutter+)
(require 'git-gutter-fringe+)

;; neutral ish colors (for zenburn at least)
(set-face-attribute 'git-gutter-fr+-added nil :foreground "#5b8258")
(set-face-attribute 'git-gutter-fr+-deleted nil :foreground "#965555")
(set-face-attribute 'git-gutter-fr+-modified nil :foreground "#936b91")

(global-git-gutter+-mode t)

;; (git-gutter-fr+-minimal) ;; <- minimal theme, grayish colors

;; hotkeys
(eval-after-load 'git-gutter+
  '(progn
     ;;; Jump between hunks
     (define-key git-gutter+-mode-map (kbd "C-c C-v C-n") 'git-gutter+-next-hunk)
     (define-key git-gutter+-mode-map (kbd "C-c C-v C-p") 'git-gutter+-previous-hunk)

     ;;; Act on hunks
     (define-key git-gutter+-mode-map (kbd "C-c C-v C-=") 'git-gutter+-show-hunk)
     (define-key git-gutter+-mode-map (kbd "C-c C-v C-r") 'git-gutter+-revert-hunks)
     ;; Stage hunk at point.
     ;; If region is active, stage all hunk lines within the region.
     (define-key git-gutter+-mode-map (kbd "C-c C-v C-s") 'git-gutter+-stage-hunks)
     (define-key git-gutter+-mode-map (kbd "C-c C-v C-c") 'git-gutter+-commit)
     ;; (define-key git-gutter+-mode-map (kbd "C-c C-v C-C") 'git-gutter+-stage-and-commit)
     (define-key git-gutter+-mode-map (kbd "C-c C-v C-b") 'git-gutter+-stage-and-commit-whole-buffer)
     (define-key git-gutter+-mode-map (kbd "C-c C-v C-u") 'git-gutter+-unstage-whole-buffer)))
