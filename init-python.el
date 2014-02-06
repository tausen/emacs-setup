;; Fancy python stuffs
; first: sudo apt-get install pyflakes pymacs

;(load-file "~/.emacs.d/lib/emacs-for-python/epy-init.el")

;; To manually specify what to load, do this:
;(add-to-list 'load-path "~/.emacs.d/lib/emacs-for-python/") ;; tell where to load the various files
;(require 'epy-setup)      ;; It will setup other loads, it is required!
;(require 'epy-python)     ;; If you want the python facilities [optional]
;(require 'epy-completion) ;; If you want the autocompletion settings [optional]
;(require 'epy-editing)    ;; For configurations related to editing [optional]
;(require 'epy-bindings)   ;; For my suggested keybindings [optional]
;(require 'epy-nose)       ;; For nose integration

;(setq skeleton-pair nil) ; disable the auto-close parenthesis from emacs-for-python

;; Hmm, something (probably emacs-for-python) overwrote C-o (insert line below point)
;; lets go ahead and redefine that one.
;(define-key global-map (kbd "C-o") 'open-line)

;; Not quite as fancy python stuffs
(add-to-list 'load-path "~/.emacs.d/lib/python/") 
(require 'python)

(setq ein:console-args '("--profile" "default"))
(require 'ein)
(add-hook 'ein:connect-mode-hook 'ein:jedi-setup)

;; Needed for jedi to function properly
(add-to-list 'load-path "~/.emacs.d/lib/popup/")
(require 'popup)

;; Epic python auto completion
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'auto-complete-mode) ; ensure auto-complete-mode is on
(add-hook 'python-mode-hook 'jedi:ac-setup)
(setq jedi:setup-keys t)                      ; optional
(setq jedi:complete-on-dot t)                 ; optional

;; autocomplete: dont suggest numbers
;; http://stackoverflow.com/questions/14767277/can-emacs-ac-mode-autocomplete-mode-be-configured-to-ignore-numbers
(eval-after-load "auto-complete"
  '(progn
     (defun ac-prefix-default ()
       "Same as `ac-prefix-symbol' but ignore a number prefix."
       (let ((start (ac-prefix-symbol)))
         (when (and start
                    (not (string-match "^\\(?:0[xX][0-9A-Fa-f]+\\|[0-9]+\\)$"
                                       (buffer-substring-no-properties start (point)))))
           start)))
     ))

;;; PYTHON LINT ;;;

;; Configure to wait a bit longer after edits before starting
(setq-default flymake-no-changes-timeout '3)

;; Keymaps to navigate to the errors
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-cn" 'flymake-goto-next-error)))
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-cp" 'flymake-goto-prev-error)))

;; To avoid having to mouse hover for the error message, these functions make flymake error messages
;; appear in the minibuffer
(defun show-fly-err-at-point ()
  "If the cursor is sitting on a flymake error, display the message in the minibuffer"
  (require 'cl)
  (interactive)
  (let ((line-no (line-number-at-pos)))
    (dolist (elem flymake-err-info)
      (if (eq (car elem) line-no)
      (let ((err (car (second elem))))
        (message "%s" (flymake-ler-text err)))))))

(add-hook 'post-command-hook 'show-fly-err-at-point)

;; use pycheckers script, https://bitbucket.org/alikins/sandbox
(when (load "flymake" t)
  (defun flymake-pycheckers-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "~/.emacs.d/lib/pycheckers.py" (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pycheckers-init)))

;; load flymake automatically for python files
(add-hook 'python-mode-hook (lambda () (flymake-mode)))

;;; END OF PYTHON LINT ;;;
