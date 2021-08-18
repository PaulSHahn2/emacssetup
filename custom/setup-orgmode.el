;;; initfile --- Summary:
;;; Commentary:
;; Emacs 26 and newer
;;; Code:

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)

(define-key global-map "\C-cc" 'org-capture)
; Log done state in TODOs
(setq org-log-done t)



; Set Org-Capture templates
(setq org-capture-templates
    `(
      ("t" "todo" entry (file+headline "~/Documents/Calendars/task.org" "Tasks")
        (file "~/org/tasks.orgcaptmpl"))
	  ("e" "event" entry (file+datetree "~/Documents/Calendars/schedule.org" "Events")
        (file "~/org/events.orgcaptmpl"))
))


;; org-caldav-sync
(setq org-agenda-files (list "~/Documents/Calendars/task.org"
                             "~/Documents/Calendars/schedule.org"))

(setq org-icalendar-timezone "GMT")
(setq org-icalendar-date-time-format ";TZID=%Z:%Y%m%dT%H%M%S")

(use-package org-caldav
:ensure t
:config
(setq org-caldav-inbox "~/Documents/Calendars/schedule.org")
(setq org-caldav-files org-agenda-files)
)

(use-package org-bullets
  :ensure t
)

(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(add-hook 'org-mode-hook (lambda () (visual-line-mode 1)))

(setq org-icalendar-alarm-time 15)
(setq org-icalendar-use-deadline (quote (event-if-todo-not-done)))
(setq org-icalendar-use-scheduled (quote (event-if-not-todo event-if-todo)))

(provide 'setup-orgmode)
