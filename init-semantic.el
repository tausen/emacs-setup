(semantic-mode 1)
(global-semantic-idle-summary-mode)
(global-semantic-idle-completions-mode)
(global-semantic-decoration-mode)
;;(global-semantic-stickyfunc-mode)
(global-semantic-highlight-func-mode)

(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "M-i") 'semantic-complete-analyze-inline)))

(global-ede-mode 1)

(load "~/.emacs.d/custom.el")

;; Also use 'locate' to find includes.
(setq ede-locate-setup-options
      '(ede-locate-locate
        ede-locate-base))

(when (file-exists-p "~/.emacs.d/init-cprojects.el")
  (load "~/.emacs.d/init-cprojects.el")
)

;; example of what you could put in init-cprojects.el:
;; (ede-cpp-root-project "myproject" :file "~/path/to/project/dummy.c"
;; 		      :include-path '( )
;; 		      :system-include-path '( "/usr/include/"
;;                                    "/usr/local/avr32/avr32-tools/avr32/include/"
;;                                    "~/path/to/an/include/you/need/include/"))
