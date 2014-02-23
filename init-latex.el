; for latex
(setq-default TeX-master nil) ; Query for master file.
(add-hook 'latex-mode-hook (lambda () (setq fill-column 9999999)))

(eval-after-load "tex"
  '(add-to-list 'TeX-command-list
                '("Make full" "make full" TeX-run-TeX t t :help "Make full") t))

(eval-after-load "tex"
  '(add-to-list 'TeX-command-list
                '("Release" "make release" TeX-run-TeX t t :help "Release") t))

; C-c C-c Make full RET to compile
; NOTE: to use latex properly, do package-install auctex or
; download, compile and install it yourself (very easy):
; http://www.gnu.org/software/auctex/download.html
; query for master file: M-x TeX-master-file-ask
; this is where auctex is installed on my system, adjust accordingly:
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
; hotkey for prompting for master file
(define-key global-map (kbd "C-c t") 'TeX-master-file-ask)

; use reftex
(add-hook 'latex-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-auctex t)

; beginning/end of line shouldnt go to actual end of line in latex, in case the line is wrapped
(add-hook 'LaTeX-mode-hook (lambda () (local-set-key (kbd "C-e") 'end-of-visual-line)))
(add-hook 'LaTeX-mode-hook (lambda () (local-set-key (kbd "C-a") 'beginning-of-visual-line)))

;; may be required?
; (require 'tex-site)
; (setq TeX-auto-save t)
; (setq TeX-parse-self t)
; (setq-default TeX-master nil)
