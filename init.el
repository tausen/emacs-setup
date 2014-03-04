
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
(load "~/.emacs.d/init-cedet.el")
(load "~/.emacs.d/init-ido.el")
(load "~/.emacs.d/init-latex.el")
(load "~/.emacs.d/init-git.el")
(load "~/.emacs.d/init-w3m.el")
(load "~/.emacs.d/init-markdown.el")

;; auto-complete
(add-to-list 'load-path "~/.emacs.d/lib/auto-complete/")
(require 'auto-complete)
;(global-auto-complete-mode 1) ; (uncomment to enable by default)

;; Semantic mode
(add-hook 'semantic-mode-hook (lambda () (global-semantic-idle-summary-mode 1)))
(add-hook 'semantic-mode-hook (lambda () (global-semantic-idle-completions-mode 1)))

;; svn for emacs23
;(add-to-list 'load-path "~/.emacs.d/lib/vc-svn17-el")
;(require 'vc-svn17)

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

(add-to-list 'load-path
              "~/.emacs.d/lib/yasnippet")
(require 'yasnippet)
(yas/global-mode 1)

; Fix yasnippets ansi-term compatibility
(add-hook 'term-mode-hook (lambda()
                            (setq yas-dont-activate t)))

; Testing out EDE
(global-ede-mode t)

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-clock-idle-time 10) ; emacs idle time before org-mode will alert of running clock
(setq org-time-clocksum-format (quote (:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t)))
(setq org-time-stamp-rounding-minutes (quote (5 5))) ; round clock times to 5 mins

(setq snake-score-file
      "~/.emacs.d/snake-scores")

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
