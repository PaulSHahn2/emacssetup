;;; setup-editing --- Summary:
;;; Commentary:
;; Emacs 26 and newer
;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Spell Checking
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flyspell
(use-package flyspell
  :ensure t
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode)
         (org-mode . flyspell-mode))
  )

(use-package flyspell-correct
  :after flyspell
  :bind (:map flyspell-mode-map ("C-;" . flyspell-correct-wrapper)))

(use-package flyspell-correct-ivy
  :after flyspell-correct)

(provide 'setup-spelling)
