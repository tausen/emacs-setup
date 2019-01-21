
(load "~/.emacs.d/init-packages.el")
(load "~/.emacs.d/init-projectile.el")
(load "~/.emacs.d/init-helm.el")
(load "~/.emacs.d/init-looks.el")
(load "~/.emacs.d/init-basics.el")
(load "~/.emacs.d/init-dired.el")
(load "~/.emacs.d/init-breadcrumb.el")
(load "~/.emacs.d/init-python.el")
(load "~/.emacs.d/init-git.el")
(load "~/.emacs.d/init-gitgutter.el")
(load "~/.emacs.d/init-markdown.el")
(load "~/.emacs.d/init-org.el")
(load "~/.emacs.d/init-c.el")
(load "~/.emacs.d/init-vhdl.el")
(load "~/.emacs.d/init-undotree.el")
(load "~/.emacs.d/init-diminish.el")
(load "~/.emacs.d/init-rst.el")
(load "~/.emacs.d/init-mu4e.el")
(load "~/.emacs.d/init-pdf.el")


;; consider removing this line for a more emacs-y experience
(load "~/.emacs.d/init-godmode.el")

(setq custom-file "~/.emacs.d/custom.el")
(unless (file-exists-p custom-file) ;; create file if it does not exist
  (write-region "" nil custom-file))
(load custom-file)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
