(add-to-list 'load-path "~/.emacs.d/lib/web-mode/")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(setq web-mode-code-indent-offset 4)

;; js2-mode for js
(add-to-list 'load-path "~/.emacs.d/lib/js2-mode/")
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(defalias 'javascript-mode 'js2-mode)

;; Hotkey for arrow (for php..)
(defun insert-arrow ()
  (interactive)
  (insert "->"))

(add-hook 'php-mode-hook (lambda () (local-set-key (kbd "C-c C-a") 'insert-arrow)))


;; Insert custom web-mode hooks here
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (local-set-key (kbd "C-c C-a") 'insert-arrow)
)
(add-hook 'web-mode-hook 'my-web-mode-hook)
