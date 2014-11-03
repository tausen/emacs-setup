
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(add-hook 'markdown-mode-hook (lambda () (local-set-key (kbd "M-p") (lambda () (interactive) (scroll-down 5)))))
(add-hook 'markdown-mode-hook (lambda () (local-set-key (kbd "M-n") (lambda () (interactive) (scroll-up 5)))))
(add-hook 'markdown-mode-hook (lambda () (local-set-key (kbd "C-s-p") (lambda () (interactive) (previous-line 5)))))
(add-hook 'markdown-mode-hook (lambda () (local-set-key (kbd "C-s-n") (lambda () (interactive) (next-line 5)))))
(add-hook 'markdown-mode-hook (lambda () (local-set-key (kbd "M-s-p") (lambda () (interactive) (scroll-previous-line 5)))))
(add-hook 'markdown-mode-hook (lambda () (local-set-key (kbd "M-s-n") (lambda () (interactive) (scroll-next-line 5)))))
