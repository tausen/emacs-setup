
;; Needed for packages installed via M-x package-install to work
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                           ("marmalade" . "http://marmalade-repo.org/packages/")
                           ("melpa" . "http://melpa.milkbox.net/packages/")))
  )
(when (<= emacs-major-version 23)
  (load "~/.emacs.d/lib/package.el")
  (require 'package)
  (add-to-list 'package-archives 
	       '("marmalade" .
		 "http://marmalade-repo.org/packages/"))
  (package-initialize)
)

;(add-to-list 'load-path "~/.emacs.d/lib/starter-kit")
;(load "~/.emacs.d/init-starter-kit.el")
(load "~/.emacs.d/lib/better-defaults/better-defaults.el")

(add-to-list 'load-path "~/.emacs.d/lib/")

;;; MAT init el
(load "~/.emacs.d/init-web.el")
(load "~/.emacs.d/init-webmode.el")
(load "~/.emacs.d/init-looks.el")
(load "~/.emacs.d/init-basics.el")
(load "~/.emacs.d/init-dired.el")
(load "~/.emacs.d/init-bfin.el")
(load "~/.emacs.d/init-term.el")
(load "~/.emacs.d/init-commands.el")
(load "~/.emacs.d/init-projectile.el")
(load "~/.emacs.d/init-hotkeys.el")
(load "~/.emacs.d/init-matlab.el")
(load "~/.emacs.d/init-python.el")
(load "~/.emacs.d/init-irc.el")
;; (load "~/.emacs.d/init-ido.el")
(load "~/.emacs.d/init-helm.el")
(load "~/.emacs.d/init-latex.el")
(load "~/.emacs.d/init-git.el")
(load "~/.emacs.d/init-w3m.el")
(load "~/.emacs.d/init-markdown.el")
(load "~/.emacs.d/init-godmode.el")
(load "~/.emacs.d/init-org.el")
(load "~/.emacs.d/init-elscreen.el")

(require 'fill-column-indicator)

;; Proper autopair/autoclose parenthesis
(add-to-list 'load-path "~/.emacs.d/lib/autopair/") ;; comment if autopair.el is in standard load path 
(require 'autopair)
;(autopair-global-mode) ;; enable autopair in all buffers
;(add-hook 'term-mode-hook #'(lambda () (setq autopair-dont-activate t))) ;; except term modes

; https://code.google.com/p/autopair/issues/detail?id=54
(add-hook 'term-mode-hook
           #'(lambda () 
               (setq autopair-dont-activate t) ;; for emacsen < 24
               (autopair-mode -1))             ;; for emacsen >= 24
)

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

(setq org-clock-idle-time 10) ; emacs idle time before org-mode will alert of running clock
(setq org-time-clocksum-format (quote (:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t)))
(setq org-time-stamp-rounding-minutes (quote (5 5))) ; round clock times to 5 mins

(setq snake-score-file
      "~/.emacs.d/snake-scores")

(load "~/.emacs.d/init-ace.el")


;; emacs semantic, autocompletion
;; (load "~/.emacs.d/init-semantic.el")

;; emacs code browser
;; (load "~/.emacs.d/init-ecb.el")

;; emacs typescript config
(load "~/.emacs.d/init-tss.el")

;; git gutter
(load "~/.emacs.d/init-gitgutter.el")
;; stop cluttering my mode line
(load "~/.emacs.d/lib/diminish.el")
(require 'diminish)
(diminish 'git-gutter+-mode)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
