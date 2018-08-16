;; autocomplete: dont suggest numbers
;; http://stackoverflow.com/questions/14767277/can-emacs-ac-mode-autocomplete-mode-be-configured-to-ignore-numbers
;; (eval-after-load "auto-complete"
;;   '(progn
;;      (defun ac-prefix-default ()
;;        "Same as `ac-prefix-symbol' but ignore a number prefix."
;;        (let ((start (ac-prefix-symbol)))
;;          (when (and start
;;                     (not (string-match "^\\(?:0[xX][0-9A-Fa-f]+\\|[0-9]+\\)$"
;;                                        (buffer-substring-no-properties start (point)))))
;;            start)))
;;      ))

;; Configure to wait a bit longer after edits before starting
(setq-default flymake-no-changes-timeout '3)

;; Keymaps to navigate to the errors
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-cn" 'flymake-goto-next-error)))
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-cp" 'flymake-goto-prev-error)))
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map (kbd "C-c f t") 'flymake-mode)))

;; To avoid having to mouse hover for the error message, these functions make flymake error messages
;; appear in the minibuffer
;(defun show-fly-err-at-point ()
;  "If the cursor is sitting on a flymake error, display the message in the minibuffer"
;  (require 'cl)
;  (interactive)
;  (let ((line-no (line-number-at-pos)))
;    (dolist (elem flymake-err-info)
;      (if (eq (car elem) line-no)
;      (let ((err (car (second elem))))
;        (message "%s" (flymake-ler-text err)))))))
;
;(add-hook 'post-command-hook 'show-fly-err-at-point)

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

(define-coding-system-alias 'UTF-8 'utf-8)

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
