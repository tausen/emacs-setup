;; zenburn theme
(when (>= emacs-major-version 24)
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/zenburn")
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/gotham")
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/monokai")
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/spacegray")
  (load-theme 'zenburn t)
)
(when (<= emacs-major-version 23)
  (load-file "~/.emacs.d/themes/zenburn-theme.el")
)

;; Highlight active buffer
(set-face-attribute  'mode-line
                 nil 
                 :foreground "gray50"
                 :background "gray15" 
                 :box '(:line-width 1 :style released-button))
(set-face-attribute  'mode-line-inactive
                 nil 
                 :foreground "gray80"
                 :background "gray25"
                 :box '(:line-width 1 :style released-button))

;; disable different background coloring w/ nxhtml
(setq initial-buffer-choice t)
(setq mumamo-chunk-coloring 900)

; line numbers, etc
;; Show line-number in the mode line
(line-number-mode 1)
;; Show column-number in the mode line
(column-number-mode 1)
;; Show battery charge in mode line
(setq battery-mode-line-format "[%L %b%p %t]")
(display-battery-mode 1)

; font size
(set-face-attribute 'default nil :height 80)

; some spacing after line numbers when using emacs no window
(unless window-system
  (add-hook 'linum-before-numbering-hook
            (lambda ()
              (setq-local linum-format-fmt
                          (let ((w (length (number-to-string
                                            (count-lines (point-min) (point-max))))))
                            (concat "%" (number-to-string w) "d"))))))

(defun linum-format-func (line)
  (concat
   (propertize (format linum-format-fmt line) 'face 'linum)
   (propertize "" 'face 'linum)))
;;              ^- put a space here for more spacing between line no and text

(unless window-system
  (setq linum-format 'linum-format-func))

;; Customize fringe: 10px left, no right, almost same background as rest (of zenburn, anyway)
(set-fringe-mode '(10 . 0))
(set-face-attribute 'fringe
                 nil 
                 :background "#3A3A3A")

;; While fringe is enabled, there's no reason to underline flymake warnings
(when (load "flymake" t)
  (set-face-attribute 'flymake-warnline
                      nil
                      :underline nil)
  (set-face-attribute 'flymake-errline
                      nil
                      :underline nil)
  (set-face-attribute 'flymake-infoline
                      nil
                      :underline nil)
  )
