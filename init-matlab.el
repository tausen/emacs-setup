;; MATLAB mode http://www.emacswiki.org/MatlabMode
(add-to-list 'load-path "~/.emacs.d/lib/matlab-emacs")
(load-library "matlab-load")
(autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
(add-to-list
 'auto-mode-alist
 '("\\.m$" . matlab-mode))
(setq matlab-indent-function t)
(setq matlab-shell-command "matlab")
(setq matlab-shell-command-switches (quote ("-nodesktop" "-nosplash")))
(define-key global-map (kbd "C-c M") 'matlab-shell)
