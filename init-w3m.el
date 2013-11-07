;; emacs-w3m
; requires w3m: sudo yum -y install w3m
(add-to-list 'load-path "~/.emacs.d/lib/emacs-w3m/")
 (setq browse-url-browser-function 'w3m-browse-url)
 (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
 ;; optional keyboard short-cut
 (global-set-key "\C-xm" 'browse-url-at-point)
(setq w3m-use-cookies t)
