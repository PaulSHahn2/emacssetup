;;; initfile --- Summary:
;;; Commentary:
;; Emacs 26 and newer
;;; Code:

(setq python-indent 4)
(setq python-indent-offset 4)

(use-package pyvenv
  :ensure t
  :init(setenv "WORKON_HOME" "~/python_venvs/"))

(require `dap-python)

;; Open Bazel config files in python mode
;; (add-to-list 'auto-mode-alist '("WORKSPACE" . python-mode))
;; (add-to-list 'auto-mode-alist '("BUILD" . python-mode))

;; uncomment all below this line to enable eply
;; instead of lsp-mode with python-lsp-server
;; also remember to edit setup-editing.el to remove lsp-mode python hooks
;; to avoid running lsp-mode and elpy concurrently

;; Emacs Python IDE
;;(use-package elpy
;;  :ensure t
;;  :defer t
;;  :init
;;  (advice-add 'python-mode :before 'elpy-enable))


;;(add-hook 'elpy-mode-hook (lambda ()
;;                            (add-hook 'before-save-hook
;;                                      'elpy-format-code nil t)))

;; Enable Flycheck
;;(with-eval-after-load 'elpy (setq elpy-modules (delq 'elpy-module-flymake elpy-modules)) (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Enable autopep8
;;(require 'py-autopep8)
;;(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;;(setq elpy-remove-modeline-lighter t)

;;(advice-add 'elpy-modules-remove-modeline-lighter
;;            :around (lambda (fun &rest args)
;;                      (unless (eq (car args) 'flymake-mode)
;;                        (apply fun args))))

(provide 'setup-python)
