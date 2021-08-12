;;; setup-editing --- Summary:
;;; Commentary:
;; Emacs 26 and newer
;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Shell Scripting Support
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'sh-mode-hook 'lsp-deferred)

;; default shell scripting hook width 4
(add-hook 'sh-mode-hook (lambda()
                          (setq tab-width 3)))

;; if a shell script, then save as executable
(add-hook 'after-save-hook #'executable-make-buffer-file-executable-if-script-p)

(provide 'setup-shell)
