;;; initfile --- Summary: General display & appearance settings
;;; Commentary:
;; Emacs 26 and newer
;;; Code:

(use-package organic-green-theme
  :ensure t)

(use-package solarized-theme
  :ensure t)

(use-package leuven-theme
  :ensure t)

(use-package zenburn-theme
 :ensure t)

(use-package immaterial-theme
 :ensure t
 :config
 (load-theme 'immaterial-dark t))

(provide 'setup-theme)
