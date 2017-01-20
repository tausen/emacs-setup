
(add-hook 'c-mode-hook (lambda () (ggtags-mode)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-t C-j") 'ggtags-find-definition)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-t C-r") 'ggtags-find-reference)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-t C-s") 'ggtags-grep)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-t C-m") 'ggtags-prev-mark)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-t C-n") 'ggtags-next-mark)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-t C-p") 'ggtags-prev-mark)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-t C-d") 'ggtags-show-definition)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "C-c C-t C-o") 'ggtags-find-other-symbol)))

(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "M-i") 'ac-complete-abbrev)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "M-o") 'ac-complete-gtags)))
(add-hook 'c-mode-hook (lambda () (auto-complete-mode)))

;; do indent after newline
(add-hook 'c-mode-common-hook (lambda () (electric-indent-mode -1)))

;; gomspace c style
(load "~/.emacs.d/lib/google-c-style.el")
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook (lambda () (setq fill-column 120)))
