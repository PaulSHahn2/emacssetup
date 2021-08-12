;;; setup-editing --- Summary:
;;; Commentary:
;; Emacs 26 and newer
;;; Code:

;; setup GDB, these settings are used by multiple language debugging backends, not just c

(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Generic code completion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; A code completion, syntax checker, etc. engine that uses the LSP to
;; talk to completion servers.
;; https://github.com/emacs-lsp/lsp-mode
(use-package lsp-mode
  :ensure t
  :init
  (use-package lsp-ui
    :ensure t
    :after lsp-mode
    :hook (lsp-mode . lsp-ui-mode)
    :config
    ;; Set useful keybindings
    (local-set-key (kbd "C-c y l") 'lsp-ui-flycheck-list)
    (local-set-key (kbd "C-c y i") 'lsp-ui-imenu)

    ;; Use find references and definitions key bindings instead of CTags.
    (defun set-local-keybinds-lsp-ui ()
      "Sets keybindings for lsp mode"
      (interactive)
      (local-set-key (kbd "M-.") 'lsp-ui-peek-find-definitions)
      (local-set-key (kbd "M-?") 'lsp-ui-peek-find-references)
      )
    (add-hook 'c-mode-common-hook 'set-local-keybinds-lsp-ui)
    (add-hook 'python-mode-hook 'set-local-keybinds-lsp-ui)
    (add-hook 'rust-mode-hook 'set-local-keybinds-lsp-ui)
    (add-hook 'shell-mode-hook 'set-local-keybinds-lsp-ui)
    )


  :config
  ;; Set GC threshold to 100MB since LSP mode is very memory hungry and
  ;; produces a lot of garbage
  (setq gc-cons-threshold 100000000)

  ;; Increase the amount of data which Emacs reads from the lsp process. The emacs
  ;; default is too low 4k considering that the some of the language server
  ;; responses are in 800k - 3M range. Set to 2MB
  (setq read-process-output-max (* 1024 2048))

  ;; Extra flags passed to clangd. See 'clangd --help' for info
  (defvar lsp-clients-clangd-args '("--clang-tidy"
                                    "--fallback-style=google"
                                    "-j=4"
                                    "--suggest-missing-includes"
                                    "--pch-storage=memory"))
  (setq lsp-enable-on-type-formatting nil)
  ;; (setq lsp-before-save-edits nil)
  ;; Use flycheck instead of flymake
  (setq lsp-prefer-flymake nil)

  (lsp-enable-which-key-integration t)
)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(provide 'setup-programming)
