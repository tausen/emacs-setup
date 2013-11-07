;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; IRC ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up with M-x customize-group znc RET
;; Then launch znc-erc with C-c x e
(global-set-key (kbd "C-c x e") 'znc-erc)

;; You should probably customize these - CUSTOMIZE ME
(setq erc-keywords '("Tausen *[,:;]" "\\bTausen[!?.]+$" "Tausen"))

;; ZNC
(add-to-list 'load-path "~/.emacs.d/lib/znc/")
(require 'znc)

;;; Sample ERC configuration from
;; http://www.gnu.org/software/emacs/manual/html_node/erc/Sample-Configuration.html#Sample-Configuration
;; Load ERC
(require 'erc)

;;; Should try this out!
;; This causes ERC to connect to the IRC server on your own machine (if
;; you have one) upon hitting C-c e b.  Replace MYNICK with your IRC
;; nick.  Often, people like to run bitlbee (http://bitlbee.org/) as an
;; AIM/Jabber/MSN to IRC gateway, so that they can use ERC to chat with
;; people on those networks.
;; (global-set-key "\C-ceb" (lambda () (interactive)
;;                            (erc :server "localhost" :port "6667"
;;                                 :nick "MYNICK")))

;;; Options - CUSTOMIZE ME
(setq erc-autojoin-channels-alist '(("tausen.org" "#innowell")))

;; Interpret mIRC-style color commands in IRC chats
(setq erc-interpret-mirc-color t)

;; Kill buffers for channels after /part
(setq erc-kill-buffer-on-part t)
;; Kill buffers for private queries after quitting the server
(setq erc-kill-queries-on-quit t)
;; Kill buffers for server messages after quitting the server
(setq erc-kill-server-buffer-on-quit t)

;; ERC NOTIFY
;;; Notify me when a keyword is matched (someone wants to reach me)
(defvar my-erc-page-message "%s is calling your name."
  "Format of message to display in dialog box")

(defvar my-erc-page-nick-alist nil
  "Alist of nicks and the last time they tried to trigger a
notification")

(defvar my-erc-page-timeout 30
  "Number of seconds that must elapse between notifications from
the same person.")

(defun my-erc-page-popup-notification (nick)
  (when window-system
    ;; must set default directory, otherwise start-process is unhappy
    ;; when this is something remote or nonexistent
    (let ((default-directory "~/"))
      ;; 8640000 milliseconds = 1 day
      (start-process "page-me" nil "notify-send"
                     "-u" "normal" "-t" "3000" "ERC"
                     (format my-erc-page-message nick)))))

(defun my-erc-page-allowed (nick &optional delay)
  "Return non-nil if a notification should be made for NICK.
If DELAY is specified, it will be the minimum time in seconds
that can occur between two notifications.  The default is
`my-erc-page-timeout'."
  (unless delay (setq delay my-erc-page-timeout))
  (let ((cur-time (time-to-seconds (current-time)))
        (cur-assoc (assoc nick my-erc-page-nick-alist))
        (last-time))
    (if cur-assoc
        (progn
          (setq last-time (cdr cur-assoc))
          (setcdr cur-assoc cur-time)
          (> (abs (- cur-time last-time)) delay))
      (push (cons nick cur-time) my-erc-page-nick-alist)
      t)))

(defun my-erc-page-me (match-type nick message)
  "Notify the current user when someone sends a message that
matches a regexp in `erc-keywords'."
  (interactive)
  (when (and (eq match-type 'keyword)
             ;; I don't want to see anything from the erc server
             (null (string-match "\\`\\([sS]erver\\|localhost\\)" nick))
             ;; or bots
             (null (string-match "\\(bot\\|serv\\)!" nick))
             ;; or from those who abuse the system
             (my-erc-page-allowed nick))
    (my-erc-page-popup-notification nick)))
(add-hook 'erc-text-matched-hook 'my-erc-page-me)

(defun my-erc-page-me-PRIVMSG (proc parsed)
  (let ((nick (car (erc-parse-user (erc-response.sender parsed))))
        (target (car (erc-response.command-args parsed)))
        (msg (erc-response.contents parsed)))
    (when (and (erc-current-nick-p target)
               (not (erc-is-message-ctcp-and-not-action-p msg))
               (my-erc-page-allowed nick))
      (my-erc-page-popup-notification nick)
      nil)))
(add-hook 'erc-server-PRIVMSG-functions 'my-erc-page-me-PRIVMSG)

(erc-match-mode 1)
