;; This is a sample of a file that stores secrets, or passwords.
;; This file should be saved in ./custom with a .gpg suffix added to it.
;; emacs will prompt you for a user key to encrypt the file for. If you skip that, you will be
;; prompted for a passphrase, enter one you wont forget. You will need it when you reboot or restart emacs.
(setq org-caldav-url "a secret goes here")
(setq org-caldav-calendar-id "another secret goes here")
(message "setup-secrets complete")
(provide 'setup-secrets)
