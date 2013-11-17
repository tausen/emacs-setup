;; nxhtml
(load "~/.emacs.d/lib/nxhtml/autostart.el")
(add-to-list 'load-path "~/.emacs.d/lib/")
;(add-to-list 'load-path "~/.emacs.d/lib/web-mode")

(add-hook 'php-mode-hook 'my-php-mode-hook)
(defun my-php-mode-hook ()   "My PHP mode configuration."
  (setq indent-tabs-mode nil
        tab-width 4
        c-basic-offset 4)
  )

; NEEDED IN NXHTML MODE
(add-hook 'php-mode-hook
          '(lambda ()
             (local-set-key ";" 'self-insert-command)
             (local-set-key "{" 'self-insert-command)))


; web-mode
;; ; https://github.com/fxbois/web-mode
;; (add-to-list 'load-path "~/.emacs.d/lib/web-mode/")
;; (require 'web-mode)
;; (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; developer notes
;; (require 'devel-notes)
;; (require 'grep)
;; (global-set-key "\C-cza" 'develnotes-add-annotation)
;; (global-set-key "\C-czv" 'develnotes-visit-file)
;; (global-set-key "\C-czt" 'develnotes-add-TODO)
;; (global-set-key "\C-czf" 'develnotes-add-FIXME)

;; php-nxml 4 tab width
;; (defun tab-width-4 ()
;;   (setq tab-width 4))
;; (add-hook 'mumamo-after-change-major-mode-hook 'tab-width-4 t)
;; (setq-default nxml-child-indent 4)

;;;;;;; WEB ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun web/trim (str)
  (replace-regexp-in-string "^[[:space:]]*\\|[[:space:]]*$" "" str))


(defun web/css-propertyp (property)
  "Checks if something can be considered a CSS property."
  (or (string= "-" (substring property 0 1))
      (member (downcase property) css-property-ids)))


(defun web/css-prettify-selectors (selectors)
  "Returns a properly sorted string with selectors."
  (concat (replace-regexp-in-string " *, *"
                                    (concat ",\n")
                                    selectors)
          " {"))


(defun web/css-fix-property-spacing ()
  "Converts things like 'color:x' to `color: x'.

It expects a properly indented CSS"
  (interactive)
  (save-excursion)
  (goto-char (point-min))
  (while (re-search-forward "^ *\\([^:]+\\) *: *" nil t)
    (if (web/css-propertyp (match-string 1))
        (replace-match (concat "    "
                               (match-string 1)
                               ": ")))))


(defun web/css-indent-buffer ()
  "Indents the whole buffer correctly."
  (interactive)
  (indent-region (point-min) (point-max)))


(defun web/css-unminify ()
  "Unminifies the whole CSS."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "{" nil t)
      (replace-match "{\n")))
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "}" nil t)
      (replace-match "\n}\n")))
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward ";" nil t)
      (replace-match ";\n")))
  (web/css-indent-buffer)
  (web/css-align-properties))


(defun web/css-align-properties ()
  "Aligns the properties with align-region"
  (interactive)
  (align-regexp (point-min) (point-max) "^ +\\([^:]+ *\\)\\(: *\\) " 2 1 nil))


(defun web/css-fix-selectors ()
  "Uses one selector per line"
  (interactive)
  (save-excursion)
  (goto-char (point-min))
  (while (re-search-forward "^\\(.+\\) *{ *" nil t)
    (replace-match (web/css-prettify-selectors (match-string 1)))))


(defun web/css-fix-brace-spacing ()
  "Fixes brace spacing"
  (interactive)
  (save-excursion)
  (goto-char (point-min))
  (while (re-search-forward " *{ *$" nil t)
    (replace-match " {")))


(defun web/css-remove-semicolons ()
  "Removes semicolons from the end of the line to make it moar clean."
  (interactive)
  (save-excursion)
  (goto-char (point-min))
  (while (re-search-forward " *; *$" nil t)
    (replace-match "")))


(defun web/css-fix-formatting ()
  "Fixes all the formatting in the file."
  (interactive)
  (web/css-fix-selectors)
  (web/css-indent-buffer)
  (web/css-fix-property-spacing)
  (web/css-fix-brace-spacing)
  (web/css-align-properties))



(defun web/css->stylus ()
  "Converts a css file to stylus"
  (interactive)
  (web/css-fix-formatting)
  (web/css-remove-semicolons))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; js2 mode
(add-to-list 'load-path "~/.emacs.d/lib/js2-mode/")
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; because nxhtml-mode forces loading .js files with javascript-mode (http://goo.gl/uc9aCl)
(defalias 'javascript-mode 'js2-mode)

;; https://gist.github.com/tkf/3951163
;; Workaround the annoying warnings:
;;    Warning (mumamo-per-buffer-local-vars):
;;    Already 'permanent-local t: buffer-file-name
(when (and (>= emacs-major-version 24)
           (>= emacs-minor-version 2))
  (eval-after-load "mumamo"
    '(setq mumamo-per-buffer-local-vars
           (delq 'buffer-file-name mumamo-per-buffer-local-vars))))
