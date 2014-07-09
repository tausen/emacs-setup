;;;;;;;;;;;;;;;;;;;;;;;;;;;,;;;;;;;;;;;;;;;;;;;;;;;;;;;,

;; package-install ecb if wanted - if not installed, dont crash n burn
(when (require 'ecb nil 'noerror)
  ;;; activate ecb
  ;; (require 'ecb)
  (require 'ecb-autoloads)

  (setq ecb-show-sources-in-directories-buffer 'always)
                                        ;(setq ecb-compile-window-height 5)
  ;;; activate and deactivate ecb
  (global-set-key (kbd "C-x C-;") 'ecb-activate)
  (global-set-key (kbd "C-x C-'") 'ecb-deactivate)
  ;;; show/hide ecb window
  (global-set-key (kbd "C-;") 'ecb-show-ecb-windows)
  (global-set-key (kbd "C-'") 'ecb-hide-ecb-windows)
  ;;; quick navigation between ecb windows
  (global-set-key (kbd "C-)") 'ecb-goto-window-edit1)
  (global-set-key (kbd "C-!") 'ecb-goto-window-directories)
  (global-set-key (kbd "C-@") 'ecb-goto-window-sources)
  (global-set-key (kbd "C-#") 'ecb-goto-window-methods)
  (global-set-key (kbd "C-$") 'ecb-goto-window-compilation)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;,;;;;;;;;;;;;;;;;;;;;;;;;;;;,
