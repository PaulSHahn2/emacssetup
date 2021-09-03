;;; setup-theme.el --- Summary: Appearance settings
;;; Commentary:
;; Emacs 28 and newer
;;; Code:

;; I like this one the best, but it
;; doesn't show rainbow delimiters very well.
(use-package immaterial-theme)

;; This is really good for org mode
(use-package leuven-theme)

(use-package organic-green-theme)

(use-package zenburn-theme)

(use-package solarized-theme
  :config
  (load-theme 'solarized-dark t))

(use-package smart-mode-line
  :config
  (sml/setup)
)

(message "setup-theme complete")

(provide 'setup-theme)
