
;; (add-hook 'php-mode-hook 'my-php-mode-hook)
;; (defun my-php-mode-hook ()   "My PHP mode configuration."
;;   (setq indent-tabs-mode nil
;;         tab-width 4
;;         c-basic-offset 4)
;;   )

(add-to-list 'load-path "~/.emacs.d/lib/php-mode/")
(require 'php-mode)

;; Hotkey for arrow (for php..)
(defun insert-arrow ()
  (interactive)
  (insert "->"))
(add-hook 'php-mode-hook (lambda () (local-set-key (kbd "C-c C-a") 'insert-arrow)))

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

;; js2-mode for js
(add-to-list 'load-path "~/.emacs.d/lib/js2-mode/")
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(defalias 'javascript-mode 'js2-mode)

;; ------------------------------------------------------------
;; php auto completion using gtags, ggtags and auto-complete

;; for this to work, install exuberant ctags, global and pygments like this:

;; wget http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz
;; tar -zxvf ctags-5.8.tar.gz
;; cd ctags-5.8
;; ./configure
;; make && sudo make install

;; wget http://tamacom.com/global/global-6.3.tar.gz
;; tar -zxvf global-6.3.tar.gz
;; cd global-6.3
;; ./configure --prefix=/usr/local --with-exuberant-ctags=/usr/local/bin/ctags
;; make && sudo make install

;; yum install python-pygments (or use pip install Pygments)

;; git clone https://github.com/yoshizow/global-pygments-plugin.git
;; cd global-pygments-plugin
;; sh reconf.sh
;; ./configure --prefix=/usr/local --with-exuberant-ctags=/usr/local/bin/ctags
;; make && make install
;; cp sample.globalrc $HOME/.globalrc

;; Important notes:

;; gtags is extremely slow over sshfs, so if you're editing files via sshfs, don't let
;; emacs run gtags for you. Run it manually on the host machine with "gtags -v" and
;; update tags using "global -u".

(add-to-list 'load-path "~/.emacs.d/lib/ggtags")
(require 'ggtags)
(add-hook 'php-mode-hook (lambda () (ggtags-mode 1)))

;; M-x package-list-packages and install popup, auto-complete (and fuzzy?)

(ac-config-default)

(add-hook 'php-mode-hook (lambda () (local-set-key (kbd "M-i") 'ac-complete-gtags)))

(add-hook 'php-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-.") 'ggtags-find-tag-dwim)))
(add-hook 'php-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-j") 'ggtags-find-definition)))
(add-hook 'php-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-c") 'tags-loop-continue)))
(add-hook 'php-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-r") 'ggtags-find-reference)))
(add-hook 'php-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-s") 'ggtags-find-other-symbol)))
(add-hook 'php-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-f") 'ggtags-find-file)))
(add-hook 'php-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-m") 'pop-tag-mark)))
(add-hook 'php-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-p") 'ggtags-prev-mark)))
(add-hook 'php-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-n") 'ggtags-next-mark))) 

;; TODO: figure out how to use this
(setq eldoc-documentation-function #'ggtags-eldoc-function)
(add-hook 'ggtags-mode-hook 'eldoc-mode)

;; ------------------------------------------------------------
