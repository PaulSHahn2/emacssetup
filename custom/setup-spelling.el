;;; setup-spelling.el --- Summary: Spell and fly minor mode settings.
;;; Commentary:
;; Emacs 28 and newer
;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Spell Checking
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flyspell
(use-package flyspell
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode)
         (org-mode . flyspell-mode))
)

(use-package flyspell-correct
  :after flyspell
  :bind (:map flyspell-mode-map ("C-;" . flyspell-correct-wrapper)))

(use-package flyspell-correct-ivy
  :after flyspell-correct)

(message "setup-spelling complete")

(provide 'setup-spelling)
