;; customize the variable org-file-apps to set pdf viewer etc

;; use __ instead of \emsp in org clock tables
(add-hook 'org-mode-hook (lambda ()
                           (defun org-clocktable-indent-string (level)
                             (if (= level 1) ""
                               (let ((str ""))
                                 (dotimes (k (1- level) str)
                                   ;; (setq str (concat "\\emsp" str))))))
                                   (setq str (concat "__" str))))))
                           ))

(add-hook 'org-mode-hook (lambda ()
                           (add-to-list 'org-clock-clocktable-language-setup
                                        '("da" "Fil" "L" "Timestamp" "Emne" "Tid" "ALL" "Total tid" "File time" "Tabel genereret"))))

;; do clocksums as fractional hours instead of hours:minutes
;; breaks setting deadline in some cases
;; (setq org-time-clocksum-format (quote (:hours "%d" :require-hours t)))
(setq org-time-clocksum-use-fractional t)

(add-hook 'org-mode-hook (lambda () (local-set-key (kbd "C-c C-S-l") 'org-store-link)))

(add-hook 'org-mode-hook (lambda () (local-set-key (kbd "M-j") 'org-meta-return)))

;; languages to allow running from org-mode code blocks
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t) (sh . t)))

;; uncomment to initially show latex fragments, inline images and pretty inline entities in org-mode
;; (add-hook 'org-mode-hook (lambda () (org-preview-latex-fragment)))
;; (add-hook 'org-mode-hook (lambda () (org-display-inline-images)))
;; (add-hook 'org-mode-hook (lambda () (org-toggle-pretty-entities)))
;;(setq org-latex-preview-ltxpng-directory "/tmp/ramdisk/")

;; when nil, inline images obey following or fall back on true img width: #+ATTR: :width 400px
;; when '(x), width x or overridden with ATTR as above
;; when x, width x always
;; when t, always true width
(setq org-image-actual-width '(400))

;; scale up latex inline math a bit
(plist-put org-format-latex-options :scale 1.5)

(global-set-key (kbd "C-c o f") 'org-iswitchb)
(global-set-key (kbd "C-c o a") 'org-agenda)

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-clock-idle-time nil) ; emacs idle time before org-mode will alert of running clock
(setq org-time-clocksum-format (quote (:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t)))
(setq org-time-stamp-rounding-minutes (quote (5 5))) ; round clock times to 5 mins

;; use google-chrome for opening URLs
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")
