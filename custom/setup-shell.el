;;; setup-shell.el --- Summary:Setup shell mode behavior
;;; Commentary:
;; Emacs 28 and newer
;;; Code:

(defvar my-term-shell "/usr/bin/bash")

(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

(add-hook 'sh-mode-hook 'lsp-deferred)

;; default shell scripting hook width 4
(add-hook 'sh-mode-hook (lambda()
                          (setq tab-width 3)))

;; if a shell script, then save with executable permissions
(add-hook 'after-save-hook #'executable-make-buffer-file-executable-if-script-p)

(use-package dired-sidebar
  :hook(term-mode . dired-sidebar-show-sidebar)
  :config
  (setq dired-sidebar-refresh-on-projectile-switch t)
  (setq dired-sidebar-should-follow-file t)
  (setq dired-sidebar-use-magit-integration t)
  (setq dired-sidebar-use-term-integration t)
)

(message "setup-shell complete")

(provide 'setup-shell)
