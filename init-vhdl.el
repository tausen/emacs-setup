
(load "~/.emacs.d/lib/vhdl-mode.el")

;; in vhdl-mode, use rising_edge() insted of clk'event and clk='1'
(setq vhdl-clock-edge-condition 'function)
;; wrap comments at column 100 rather than 80
(setq vhdl-end-comment-column 100)
(setq vhdl-inline-comment-column 80)
(add-hook 'vhdl-mode-hook (lambda () (setq fill-column 100)))
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
;;(setq vhdl-actual-port-name (quote ("\\(.*?\\)\\(_[io]\\)?$" . "\\1_s")))
;; update: no longer using _s
(setq vhdl-actual-port-name (quote ("\\(.*?\\)\\(_[io]\\)?$" . "\\1")))

;; ;; (setq vhdl-types (remove "bc_bytearray" vhdl-keywords))
;; (add-to-list 'vhdl-types "bc_bytearray")
;; ;; (vhdl-words-init)
;; (setq vhdl-types-regexp
;; 	(concat "\\<\\(" (regexp-opt vhdl-types) "\\)\\>"))
;; (vhdl-abbrev-list-init)
;; (vhdl-words-init)

(defun my-vhdl-port-map-add-s-suffix ()
  "In a region, add _s to signals on right-hand side of =>"
  (interactive)
  (replace-regexp "\\(.*=> .*\\)\\([,|)]\\)" "\\1_s\\2" nil (region-beginning) (region-end)))

(defun my-vhdl-port-map-add-c-suffix ()
  "In a region, add _c to signals on right-hand side of =>"
  (interactive)
  (replace-regexp "\\(.*=> .*\\)\\([,|)]\\)" "\\1_c\\2" nil (region-beginning) (region-end)))

(defun my-vhdl-port-map-remove-suffix ()
  "In a region, remove _o, _i, _g, _c and _s suffixes on right-hand side of =>"
  (interactive)
  (replace-regexp "\\(.*=> .*\\)\\(_[o|i|s|g|c]\\)\\([,|)].*\\)" "\\1\\3" nil (region-beginning) (region-end)))

(defun my-vhdl-signal-def-remove-suffix ()
  ""
  (interactive)
  (replace-regexp "\\(signal [a-zA-Z0-9_]*\\)\\(_[o|i|s]\\) \\(.*\\)" "\\1 \\3" nil (region-beginning) (region-end)))

(defun my-vhdl-signal-def-add-suffix ()
  ""
  (interactive)
  (replace-regexp "\\(signal [a-zA-Z0-9_]*\\) \\(.*\\)" "\\1_s \\2" nil (region-beginning) (region-end)))

;; (defun my-vhdl-signal-def-add-suffix ()
;;   ""
;;   (interactive)
;;   (replace-regexp "\\(signal [a-zA-Z0-9_]*\\) \\(.*\\)" "\\1_s \\2" nil (region-beginning) (region-end)))

;; vhdl testbench template
(setq vhdl-testbench-declarations "  -- clock
  signal clk : std_logic := '1';
")
(setq vhdl-testbench-include-configuration nil)
(setq vhdl-testbench-initialize-signals nil)
(setq vhdl-testbench-statements "  -- clock generation
  clk <= not clk after 10 ns;

  -- waveform generation
  proc : process
  begin
    test_runner_setup(runner, runner_cfg);

        while test_suite loop

            -- initialization

            -- individual test cases
            if run(\"testcase\") then
            
            end if;

        end loop;

        if run_forever then
            wait;
        end if;

        test_runner_cleanup(runner);    -- simulation ends here
    end process proc;")
