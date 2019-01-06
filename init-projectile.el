
;; http://batsov.com/projectile/
;; C-c p f: find file in project
;; C-c p c: compile project
;; C-u C-c p c: compile project but prompt for compile command
;; C-c p R: recompile TAGS

(require 'flx)
(require 'dash)
(require 's)

(require 'projectile)
;; (projectile-global-mode)

;; Allows C-c p R to recompile tags
;; my ctags did not recognize the -e option, so had to install
;; ctags-exuberant and use that instead
(setq projectile-tags-command "ctags-exuberant -Re %s")

;; Don't prompt for compilation command unless prefix command
(setq compilation-read-command nil)

;; Browse tags in project
;; http://www.emacswiki.org/emacs/InteractivelyDoThings
(defun ido-find-tag ()
  "Find a tag using ido"
  (interactive)
  (tags-completion-table)
  (let (tag-names)
    (mapatoms (lambda (x)
                (push (prin1-to-string x t) tag-names))
              tags-completion-table)
    (find-tag (ido-completing-read "Tag: " tag-names))))
(global-set-key (kbd "C-c p .") 'ido-find-tag)

;; enable projectile project caching
(setq projectile-enable-caching t)
(setq projectile-indexing-method 'alien)

;; Stop cluttering my mode line
(setq projectile-mode-line (quote (:eval (format " P[%s]" (projectile-project-name)))))

;; in case projectile is slow when using tramp, do something like
;;(setq projectile-mode-line "P")

(global-set-key (kbd "C-c p a") 'projectile-find-other-file)

(projectile-mode 1)

(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; workaround for user-error: The value for: compile-command in project-type: generic was neither a function nor a string.
;; https://github.com/bbatsov/projectile/pull/1269
(setq projectile-project-compilation-cmd "")
