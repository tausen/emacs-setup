
(semantic-mode t)
(global-ede-mode t)

;; A few modes that may be of interest
;; (global-semantic-idle-summary-mode)
;; (global-semantic-idle-completions-mode)
;; (global-semantic-stickyfunc-mode)
;; (global-semantic-decoration-mode)
;; (global-semantic-highlight-func-mode)

;; Do C-x B to switch to most recently used tag
(global-semantic-mru-bookmark-mode t)

;; Do M-i to get completions at point and M-æ to get summary of function at point in minibuffer
;; M-n and M-p to cycle completions
;; C-c C-- C-j  -- jump to tag
;; C-c C-, C-l  -- list possible completions
;; C-c C-, C-g  -- prompt for tag, show list of callers
;; C-c C-, C-G  -- display list of callers of current tag
;; semantic-complete-jump-local is by default bound to C-c , j
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "M-æ") 'semantic-ia-show-summary)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "M-i") 'semantic-complete-analyze-inline)))

;; Do M-i to get completions at point and M-æ to get summary of function at point in minibuffer
;; M-n and M-p to cycle completions
;; C-c C-- C-j  -- jump to tag
;; C-c C-, C-l  -- list possible completions
;; C-c C-, C-g  -- prompt for tag, show list of callers
;; C-c C-, C-G  -- display list of callers of current tag
;; semantic-complete-jump-local is by default bound to C-c , j
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "M-æ") 'semantic-ia-show-summary)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "M-i") 'semantic-complete-analyze-inline)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-s") 'semantic-ia-show-summary)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-c") 'semantic-complete-analyze-inline)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-j") 'semantic-complete-jump)))
;; just for testing, not sure what the difference is between ia-fast-jum and complete-jump
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-J") 'semantic-ia-fast-jump))) 
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-r") 'semantic-symref-symbol)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-m") 'semantic-mrub-switch-tags)))

;; NOTE: Hmm, still not working entirely as intended. Must do M-x global-ede-mode the first time a c file
;; is opened and reopen the file (C-x v RET) for semantics to work. Adding global-ede-mode to c-mode-hook does
;; not work.

(require 'semantic/sb) ;; speedbar + semantic

;; Also use 'locate' to find includes.
(setq ede-locate-setup-options
      '(ede-locate-locate
        ede-locate-base))

;; load a file with project defs if it uses a fancy build system
(when (file-exists-p "~/.emacs.d/init-cprojects.el")
  (load "~/.emacs.d/init-cprojects.el")
)

;; example of what you could put in init-cprojects.el:
;; (ede-cpp-root-project "myproject" :file "~/path/to/project/dummy.c"
;; 		      :include-path '( )
;; 		      :system-include-path '( "/usr/include/"
;;                                    "/usr/local/avr32/avr32-tools/avr32/include/"
;;                                    "~/path/to/an/include/you/need/include/"))
