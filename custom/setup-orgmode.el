;;; setup-orgmode.el --- Summary: Setup org mode settings.
;;; Commentary:
;; Emacs 28 and newer
;;; Code:

(use-package org
  :config
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  (global-set-key "\C-cl" 'org-store-link)
  (global-set-key "\C-ca" 'org-agenda)
  (define-key global-map "\C-cc" 'org-capture)
  ;; Log done state in TODOs
  (setq org-log-done t)
  ;; Set Org-Capture templates
  (setq org-capture-templates
        `(
          ("t" "todo" entry (file+headline "~/Documents/Calendars/task.org" "Tasks")
           (file "~/org/tasks.orgcaptmpl"))
	       ("e" "event" entry (file+datetree "~/Documents/Calendars/schedule.org" "Events")
           (file "~/org/events.orgcaptmpl"))
          )
   )
  ;; org-caldav-sync
  (setq org-agenda-files (list "~/Documents/Calendars/task.org"
                               "~/Documents/Calendars/schedule.org"))

  (setq org-icalendar-timezone "GMT")
  (setq org-icalendar-date-time-format ";TZID=%Z:%Y%m%dT%H%M%S")
  (setq org-icalendar-alarm-time 15)
  (setq org-icalendar-use-deadline (quote (event-if-todo-not-done)))
  (setq org-icalendar-use-scheduled (quote (event-if-not-todo event-if-todo)))
  (add-hook 'org-mode-hook (lambda () (visual-line-mode 1)))
)

;; this has org-contacts.el in this misc package of everything.
(use-package org-contrib
  :after org
  :custom (org-contacts-files '("~/Documents/Contacts/contacts.org"))
)

;; org-contrib provides with an org-contacts. This setup that can work with e-mail, etc
(require 'org-contacts)

;; to get vcard data into org-contacts we need vdirel and vdirsyncer

;; You will want to install vdirsyncer, I install to virtual env via pip. Virtual env must be enabled before emacs daemon is started.
;; This will pull contacts list from server. Then org-vcard will put it into org-contacts.
;; You will need to create a ~/.vdirsyncer/config file. A sample is in skel/vdirsyncer-config.
;; Need to fork vdirel to not use helm and sync with vdirsyncer discover and vdirsyncer sync
;; both ways using org-vcard. Like org-caldav, preferably with same interface.
(use-package org-vcard)


(use-package org-caldav
  :after org
  :config
  (setq org-caldav-inbox "~/Documents/Calendars/schedule.org")
  (setq org-caldav-files org-agenda-files)
)

(use-package org-bullets
  :after org
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
)

(use-package org-tree-slide
  :custom
  (org-image-actual-width nil))

(message "setup-orgmode complete")

(provide 'setup-orgmode)
