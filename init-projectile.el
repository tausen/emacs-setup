
;; http://batsov.com/projectile/
;; C-c p f: find file in project
;; C-c p c: compile project
;; C-u C-c p c: compile project but prompt for compile command
;; C-c p R: recompile TAGS

;; Dependencies
(add-to-list 'load-path "~/emacs.d/lib/flx")
(add-to-list 'load-path "~/emacs.d/lib/dash")
(add-to-list 'load-path "~/emacs.d/lib/s")
(add-to-list 'load-path "~/emacs.d/lib/f")

(load "~/.emacs.d/lib/flx/flx.el")
(load "~/.emacs.d/lib/dash/dash.el")
(load "~/.emacs.d/lib/s/s.el")
(load "~/.emacs.d/lib/f/f.el")

(require 'flx)
(require 'dash)
(require 's)

(add-to-list 'load-path "~/emacs.d/lib/projectile")
(load "~/.emacs.d/lib/projectile/projectile.el")
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

(projectile-global-mode)
