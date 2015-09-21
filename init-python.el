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

(when (fboundp 'ein:tb-show) ;; only if ein is installed
  (setq ein:console-args '("--profile" "default"))
  (require 'ein)
  (add-hook 'ein:connect-mode-hook 'ein:jedi-setup))

;; Needed for jedi to function properly
(add-to-list 'load-path "~/.emacs.d/lib/popup/")
(require 'popup)

;; Epic python auto completion
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'auto-complete-mode) ; ensure auto-complete-mode is on
(add-hook 'python-mode-hook 'jedi:ac-setup)
(when (fboundp 'ein:tb-show) ;; only if ein is installed
  (add-hook 'ein:notebook-multilang-mode-hook 'jedi:ac-setup))
;(setq jedi:setup-keys t)                      ; optional
;; (setq jedi:complete-on-dot t)                 ; optional

(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "C-c d") 'jedi:show-doc)))
(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "C-c i") 'jedi:complete)))
(when (fboundp 'ein:tb-show) ;; only if ein is installed
  (add-hook 'ein:notebook-multilang-mode-hook (lambda () (local-set-key (kbd "C-c i") 'jedi:complete)))
  (add-hook 'ein:notebook-multilang-mode-hook (lambda () (local-set-key (kbd "C-c d") 'jedi:show-doc))))

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
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map (kbd "C-c f t") 'flymake-mode)))

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

;; http://stackoverflow.com/questions/5793839/can-flymakes-temporary-file-be-created-in-the-systems-temporary-directory
(when (load "flymake" t)
  (defun flymake-create-temp-in-system-tempdir (filename prefix)
    (make-temp-file (or prefix "flymake")))

  (defun flymake-pycheckers-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-in-system-tempdir))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "~/.emacs.d/lib/pycheckers.py" (list temp-file))))

  (add-to-list 'flymake-allowed-file-name-masks '("\\.py\\'" flymake-pycheckers-init))
  )

;; load flymake automatically for python files
(add-hook 'python-mode-hook (lambda () (flymake-mode)))
;; (remove-hook 'python-mode-hook (lambda () (flymake-mode)))

;;; END OF PYTHON LINT ;;;

;; ipython interpreter
;; run buffer with C-c C-c
;; show ipython with C-c C-z
(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args ""
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
 "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
 "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
 "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

;; Easier to press these with godmode
(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "C-c C-<") 'python-indent-shift-left)))
(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "C-c C->") 'python-indent-shift-right)))

;; Auto-completion etc. using gtags (requires gnu global, http://www.gnu.org/software/global/, and pygments plug-in parser https://github.com/yoshizow/global-pygments-plugin)
(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "M-i") 'ac-complete-gtags)))
(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-.") 'ggtags-find-tag-dwim)))
(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-j") 'ggtags-find-definition)))
(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-c") 'tags-loop-continue)))
(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-r") 'ggtags-find-reference)))
(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-s") 'ggtags-find-other-symbol)))
(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-f") 'ggtags-find-file)))
(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-m") 'pop-tag-mark)))
(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-p") 'ggtags-prev-mark)))
(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "C-c C-- C-n") 'ggtags-next-mark))) 
(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "C-c C-- C--") 'ggtags-grep)))

;; Set fill column to 79 when in python-mode
(add-hook 'python-mode-hook (lambda () (setq fill-column 79)))

;; Enable fci-mode and do some fci-related tweaks
;; (add-hook 'python-mode-hook (lambda () (setq visual-line-mode nil)))
;; (add-hook 'python-mode-hook (lambda () (fci-mode t)))
;; (add-hook 'python-mode-hook (lambda () (local-set-key (kbd "C-a") 'beginning-of-line)))
;; (add-hook 'python-mode-hook (lambda () (local-set-key (kbd "C-e") 'end-of-line)))
;; turns out fci-mode and linum-mode arent the best of friends - slows down emacs significantly..

(defun python-skeleton-includes ()
  (interactive)
  (insert "from __future__ import division\n")
  (insert "import numpy as np\n")
  (insert "import matplotlib.pyplot as plt\n")
  (insert "import scipy.signal as ss\n"))
(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "C-c C-t h") 'python-skeleton-includes)))
