;; Requires mu4e:
;; sudo apt install mu4e

;; Example setup:
;; - davmail to bridge from MS exchange to IMAP
;;   - Grab from http://davmail.sourceforge.net/. Can run out of memory in case of huge
;;     attachments - can be resolved by changing -Xmx512M argument in /usr/bin/davmail.
;; - offlineimap to synchronize mail using IMAP
;;   - Grab from https://github.com/OfflineIMAP/offlineimap/releases
;; - mu4e to view emails
;;   - First index: mu index -m ~/mail
;;   - Installed via apt
;; - vdirsyncer to synchronize calendar
;;   - Installed via pip3
;;   - Running with this for now: while true; do vdirsyncer sync; sleep 300; done
;; - khal to view calendar
;;   - Installed via pip3, configure with: khal configure

;; Also using w3m (installed via apt) to read html mails
;; To view an email as pdf (in emacs e.g. using pdf-tools), install
;; maildir-utils-extra via apt. Then press a v in a mu4e-view buffer.

;; To send mail, create a GPG encrypted file with your login credentials in
;; ~/.authinfo.gpg. Simply saving that file through emacs will prompt for a
;; passphrase and automatically encrypt it. Syntax:
;;   machine HOST login USERNAME password PASSWORD port PORT
;; where HOST, USERNAME and PORT must match those in smtpmail-smtp-server,
;; smtpmail-smtp-user and smtpmail-smtp-service set later in this file.

;; no idea why this line is necessary - it should not be
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e/")

(require 'mu4e)

;; use mu4e for e-mail in emacs
(setq mail-user-agent 'mu4e-user-agent)

;; path to our Maildir directory
(setq mu4e-maildir "~/mail")

;; the next are relative to `mu4e-maildir'
;; instead of strings, they can be functions too, see
;; their docstring or the chapter 'Dynamic folders'
(setq mu4e-sent-folder   "/Sent"
      mu4e-drafts-folder "/Drafts"
      mu4e-trash-folder  "/trash")

;; the maildirs you use frequently; access them with 'j' ('jump')
;; (setq   mu4e-maildir-shortcuts
;;     '(("/archive"     . ?a)
;;       ("/inbox"       . ?i)
;;       ("/work"        . ?w)
;;       ("/sent"        . ?s)))

;; a  list of user's e-mail addresses
(setq mu4e-user-mail-address-list '("EMAIL@ADDRESS.HERE"))

;; the headers to show in the headers list -- a pair of a field
;; and its width, with `nil' meaning 'unlimited'
;; (better only use that for the last field.
;; These are the defaults:
(setq mu4e-headers-fields
    '( (:human-date    .  12)    ;; alternatively, use :human-date
       (:flags         .   6)
       (:from          .  22)
       (:subject       .  nil))) ;; alternatively, use :thread-subject

;; If you get your mail without an explicit command,
;; use "true" for the command (this is the default)
;; (setq mu4e-get-mail-command "offlineimap")

;; general emacs mail settings; used when composing e-mail
;; the non-mu4e-* stuff is inherited from emacs/message-mode
(setq mu4e-confirm-quit nil
      mu4e-sent-messages-behavior 'delete
      mu4e-reply-to-address "EMAIL@ADDRESS.HERE"
      user-mail-address "EMAIL@ADDRESS.HERE"
      user-full-name  "NAME HERE")
(setq mu4e-compose-signature
   "Kind regards,\n-NAME HERE.\n")

;; smtp mail setting
(setq
   message-send-mail-function 'smtpmail-send-it
   smtpmail-smtp-user "USERNAME"
   smtpmail-local-domain "DOMAIN"
   smtpmail-smtp-service 1025
   smtpmail-smtp-server "localhost"

   starttls-use-gnutls t
   smtpmail-stream-type nil

   ;; if you need offline mode, set these -- and create the queue dir
   ;; with 'mu mkdir', i.e.. mu mkdir /home/user/Maildir/queue
   ;; smtpmail-queue-mail  nil
   ;; smtpmail-queue-dir  "/home/user/Maildir/queue/cur"
)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

;; disable visual-line-mode in mu4e headers view
(add-hook 'mu4e-headers-mode-hook (lambda () (visual-line-mode -1)))

;; no line wrapping in outgoing mail
(add-hook 'mu4e-compose-mode-hook (lambda () (auto-fill-mode -1)))
(add-hook 'mu4e-compose-mode-hook (lambda () (set-fill-column 99999999)))

;; looks like this used to be a thing - but not defined in current version of mu4e
;; (setq mu4e-compose-format-flowed t)

;; don't ask so many questions when attaching files
(add-hook 'mu4e-compose-mode-hook (lambda () (local-set-key (kbd "C-c C-a") 'mail-add-attachment)))

;; support encrypted authinfo for smtp
(setq epg-gpg-program "gpg2")

;; how to show html messages
(setq mu4e-html2text-command "w3m -o display_link_number=true -T text/html;")

;; custom bookmarks
(add-to-list 'mu4e-bookmarks
	     '("maildir:/INBOX and flagged" "Flagged messages" ?f))
(add-to-list 'mu4e-bookmarks
	     '("maildir:/INBOX" "Inbox" ?i))

;; enable popup notifications
(mu4e-alert-set-default-style 'libnotify)
(add-hook 'after-init-hook #'mu4e-alert-enable-notifications)
(setq mu4e-alert-email-notification-types '(subjects))  ;; only popup with subjects, not count

;; show number of unread mails in inbox in mode-line 
(add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)
(setq mu4e-alert-interesting-mail-query
      (concat
       "flag:unread"
       " AND NOT flag:trashed"
       " AND maildir:/INBOX"))  ;; only consider unread mails in inbox

;; update index every 2mins, but assume offlineimap runs elsewhere
;; (setq mu4e-get-mail-command "offlineimap")
(setq mu4e-update-interval 120)

(setq
 mu4e-index-cleanup nil      ;; don't do a full cleanup check
 mu4e-index-lazy-check t)    ;; don't consider up-to-date dirs

;; show full addresses in view message (instead of just names)
;; toggle per name with M-RET
(setq mu4e-view-show-addresses 't)

;; fix compatibility issues with openwith
(add-to-list 'mm-inhibit-file-name-handlers 'openwith-file-handler)

;; hotkeys to show mu4e main window
(global-set-key (kbd "C-c µ") (lambda () (interactive) (mu4e)))
(global-set-key (kbd "C-c M") (lambda () (interactive) (mu4e)))

;; start mu4e in background on emacs launch
;;(mu4e~start)

;; mu4e+org: https://vxlabs.com/2015/01/28/sending-emails-with-math-and-source-code/
;; https://etienne.depar.is/emacs.d/mu4e.html
;; https://vxlabs.com/2017/02/07/mu4e-0-9-18-e-mailing-with-emacs-now-even-better/
;; https://github.com/iqbalansari/mu4e-alert
;; choosing pdf viewer for xdg-open: https://emacs.stackexchange.com/questions/19686/how-to-use-pdf-tools-pdf-view-mode-in-emacs
