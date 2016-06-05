
;; (add-hook 'php-mode-hook 'my-php-mode-hook)
;; (defun my-php-mode-hook ()   "My PHP mode configuration."
;;   (setq indent-tabs-mode nil
;;         tab-width 4
;;         c-basic-offset 4)
;;   )

(add-to-list 'load-path "~/.emacs.d/lib/php-mode/")
(require 'php-mode)

;; sass mode for scss files
(add-to-list 'load-path "~/.emacs.d/lib/haml-mode/")
(require 'haml-mode)
(add-to-list 'load-path "~/.emacs.d/lib/sass-mode/")
(require 'sass-mode)
(add-to-list 'auto-mode-alist '("\\.scss\\'" . sass-mode))

;; Hotkey for arrow (for php..)
(defun insert-arrow ()
  (interactive)
  (insert "->"))
(add-hook 'php-mode-hook (lambda () (local-set-key (kbd "C-c C-a") 'insert-arrow)))

(defun insert-php-comment ()
  (interactive)
  (let ((start (point)))  ; store starting pos

    ;; insert php comment
      (insert 
       "/**
         * Short description.
         * Longer description.
         *
         * @param type $param description of param
         * @return type description of return value
         */"
       )

      ;; indent from starting pos to new point
      (indent-region start (point)))
  )
(add-hook 'php-mode-hook (lambda () (local-set-key (kbd "C-c C-b") 'insert-php-comment)))

;; EXAMPLE:
(defun insert-php-this ()
  (interactive)
  (insert "$this->"))
(add-hook 'php-mode-hook (lambda () (local-set-key (kbd "C-c C-t") 'insert-php-this)))

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

(global-auto-complete-mode t)
(ac-config-default)

;; don't show auto-complete stuff automatically
(setq ac-auto-show-menu nil)
(setq ac-auto-start nil)

;; Auto-completion etc. using gtags (requires gnu global, http://www.gnu.org/software/global/, and pygments plug-in parser https://github.com/yoshizow/global-pygments-plugin)(add-hook 'php-mode-hook (lambda () (local-set-key (kbd "M-i") 'ac-complete-gtags)))
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
(add-hook 'php-mode-hook (lambda () (local-set-key (kbd "C-c C-- C--") 'ggtags-grep)))

;; trying out tern for most of these - lets use gtags for what tern does not support
;; (add-hook 'js2-mode-hook (lambda () (local-set-key (kbd "M-i") 'ac-complete-gtags)))
;; (add-hook 'js2-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-.") 'ggtags-find-tag-dwim)))
;; (add-hook 'js2-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-j") 'ggtags-find-definition)))
;; (add-hook 'js2-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-c") 'tags-loop-continue)))
(add-hook 'js2-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-r") 'ggtags-find-reference)))
(add-hook 'js2-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-s") 'ggtags-find-other-symbol)))
(add-hook 'js2-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-f") 'ggtags-find-file)))
;; (add-hook 'js2-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-m") 'pop-tag-mark)))
;; (add-hook 'js2-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-p") 'ggtags-prev-mark)))
;; (add-hook 'js2-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-n") 'ggtags-next-mark)))
(add-hook 'js2-mode-hook (lambda () (local-set-key (kbd "C-c C-- C--") 'ggtags-grep)))

;; TODO: figure out how to use this
(setq eldoc-documentation-function #'ggtags-eldoc-function)
;; (add-hook 'ggtags-mode-hook 'eldoc-mode)

;; (add-hook 'php-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-u") 'global-ssh-update)))
;; (add-hook 'js2-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-u") 'global-ssh-update)))

;; trying out tern for smarter JS completion...
;; http://ternjs.net/doc/manual.html#emacs
;; tern default keys:
;; M-.      Jump to the definition of the thing under the cursor
;; M-,      Brings you back to last place you were when you pressed M-.
;; C-c C-r  Rename the variable under the cursor
;; C-c C-c  Find the type of the thing under the cursor
;; C-c C-d  Find docs of the thing under the cursor. Press again to open the associated URL (if any)
(add-to-list 'load-path "~/.emacs.d/lib/tern/emacs")
(autoload 'tern-mode "tern.el" nil t)
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))
(add-hook 'js2-mode-hook (lambda () (local-set-key (kbd "M-i") 'tern-ac-complete)))
(add-hook 'js2-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-j") 'tern-find-definition)))
(add-hook 'js2-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-m") 'tern-pop-find-definition)))

;; define options, commands and keybindings for running "global -u" from a dir on a remote shell
;; to set up, do M-x customize-group global-ssh
(defgroup global-ssh nil
  "Setup for running global -u via remote shell"
  :prefix "global-ssh-"
  :group 'convenience)

(defcustom global-ssh-username ""
  "SSH username for remote global -u"
  :type 'string
  :group 'global-ssh)

(defcustom global-ssh-host ""
  "SSH host for remote global -u"
  :type 'string
  :group 'global-ssh)

(defcustom global-ssh-path ""
  "Path to dir with GTAGS file for remote global -u"
  :type 'string
  :group 'global-ssh)

(defcustom global-ssh-port "22"
  "SSH port for remote global -u"
  :type 'string
  :group 'global-ssh)

(defun global-ssh-update ()
   (interactive)
   (shell-command (concat "ssh -p " global-ssh-port " " global-ssh-username "@" global-ssh-host " 'cd " global-ssh-path " && global -u'")))

;; ------------------------------------------------------------

(add-hook 'js2-init-hook 'my-js2-init-hook)

;; project-specific js2-mode externs (variables that should always be considered defined)
;; try also js2-global-externs via M-x customize-group js2-mode
;; example value: '("$" "setTimeout" "WebSocket")
(defun my-js2-init-hook ()  "My js2-mode init hook"
  (when (string-match-p "gomspace/csp-web" (buffer-file-name))
    (setq js2-additional-externs '("GDO" "noty"))
    )
  )

;; easy jdoc
(load "~/.emacs.d/lib/js-doc.el")
(require 'js-doc)

(add-hook 'js2-mode-hook
          #'(lambda ()
              (define-key js2-mode-map "\C-ci" 'js-doc-insert-function-doc)
              (define-key js2-mode-map "@" 'js-doc-insert-tag)))
