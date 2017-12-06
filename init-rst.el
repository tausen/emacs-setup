
(add-hook 'rst-mode-hook (lambda () (auto-complete-mode)))

;; RST include files: use rst-mode
(add-to-list 'auto-mode-alist '("\\.rsti\\'" . rst-mode))

;; follow GS standard sphinx format
(setq rst-default-indent 0)
(setq rst-new-adornment-down t)
(setq rst-preferred-adornments
   (quote
    ((?# over-and-under 0)
     (?* over-and-under 0)
     (?= simple 0)
     (?- simple 0)
     (?^ simple 0))))
