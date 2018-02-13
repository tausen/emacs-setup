
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

(add-hook 'vhdl-mode-hook (lambda () (local-set-key (kbd "M-o") 'ac-complete-with-helm)))
(add-hook 'vhdl-mode-hook (lambda () (auto-complete-mode)))
(add-hook 'vhdl-mode-hook (lambda () (setq ac-use-menu-map t)))
(ac-config-default)

;; when using vhd-port-paste-*, strip off tailing _i or _o and append _s to port names
;; note: important that first .* is followed by ? to make it not greedy
(setq vhdl-actual-port-name (quote ("\\(.*?\\)\\(_[io]\\)?$" . "\\1_s")))
