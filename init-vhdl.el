
(load "~/.emacs.d/lib/vhdl-mode.el")

;; in vhdl-mode, use rising_edge() insted of clk'event and clk='1'
(setq vhdl-clock-edge-condition 'function)
;; wrap comments at column 120 rather than 80
(setq vhdl-end-comment-column 120)
(setq vhdl-indent-tabs-mode nil)
(setq vhdl-basic-offset 4)
(add-hook 'vhdl-mode-hook (lambda () (auto-complete-mode)))
;(add-hook 'vhdl-mode-hook (lambda () (local-set-key (kbd "TAB") 'auto-complete)))
(add-hook 'vhdl-mode-hook (lambda () (local-set-key (kbd "TAB") 'vhdl-indent-line)))
