(add-to-list 'load-path "~/.emacs.d/lib/web-mode/")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl?\\'" . web-mode))

;; I prefer php-mode for php files, could put web-mode here as well
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode)) 

(setq web-mode-code-indent-offset 4)

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (local-set-key (kbd "C-c C-a") 'insert-arrow)
)
(add-hook 'web-mode-hook 'my-web-mode-hook)
