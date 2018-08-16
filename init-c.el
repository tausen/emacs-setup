
;; completion and navigation using gtags
;; to use, run gtags in root dir of the project (or use any ggtags cmd in emacs to be prompted)
;; most important:
;; - start typing for completion, M-n and M-p to choose next/prev candidate, RET to confirm
;;   while completing, C-s to search or M-o for helm fuzzy search
;; - jump to definition using C-c C-t C-j
;;   if multiple matches, navigate to next/prev with C-x n and C-x p
;; - jump back to where you came from with C-c C-t C-m
;; - same goes for finding references with C-c C-t C-r

(add-hook 'c-mode-hook (lambda () (ggtags-mode)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-t C-j") 'ggtags-find-definition)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-t C-r") 'ggtags-find-reference)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-t C-s") 'ggtags-grep)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-t C-m") 'ggtags-prev-mark)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-t C-n") 'ggtags-next-mark)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-t C-p") 'ggtags-prev-mark)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-t C-d") 'ggtags-show-definition)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-t C-o") 'ggtags-find-other-symbol)))

; testing out company completion...
;; (add-hook 'c-mode-hook (lambda () (local-set-key (kbd "M-o") 'ac-complete-with-helm)))
;; (add-hook 'c-mode-hook (lambda () (auto-complete-mode)))
;; (add-hook 'c-mode-hook (lambda () (setq ac-use-menu-map t)))
;; (ac-config-default)

;; testing out eldoc mode - not yet added to init-packages
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)

;; do indent after newline
(add-hook 'c-mode-common-hook (lambda () (electric-indent-mode -1)))

;; gomspace c style
(load "~/.emacs.d/lib/google-c-style.el")
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook (lambda () (setq fill-column 120)))

(defun gs-old-indent-mode ()
  "Switch to old GomSpace indent mode: 8-space tabs"
  (interactive)
  (setq c-basic-offset 8)
  (setq indent-tabs-mode t)
  (setq tab-width 8)
  (c-set-offset 'case-label nil)
  )
