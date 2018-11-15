; list the packages you want
(setq package-list '(;;better-defaults ;; no longer available?
                     ggtags
                     popup
                     ;; auto-complete
                     fuzzy
                     helm
                     magit
                     org
                     undo-tree
                     multiple-cursors
                     adaptive-wrap
                     openwith
                     ;;dired+ ;; no longer available?
                     ;;image-dired+ ;; no longer available?
                     projectile
                     python
                     smex
                     helm-projectile
                     ac-helm
                     winner
                     git-gutter+
                     git-gutter-fringe+
                     undo-tree
                     diminish
                     flx
                     s
                     cl
                     auto-complete-rst
                     company
                     company-flx
                     vhdl-capf))

;;                     org-plus-contrib))

; list the repositories containing them
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
