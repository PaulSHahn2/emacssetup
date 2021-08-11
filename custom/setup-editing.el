;;; setup-editing --- Summary:
;;; Commentary:
;; Emacs 26 and newer
;;; Code:

;; Default column fill is 160, not 80.
(setq-default fill-column 160)

;; various default variables
(setq global-mark-ring-max 5000;
      mark-ring-max 5000;
      mode-require-final-newline t;
      tab-width 3;
      )

;; prefer utf8 to ascii
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

;; don't disable downcase and upcase region. I use them frequently.
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; tabs are evil, shut this off
(setq-default indent-tabs-mode nil)

;; when text is selected, you may type to delete and replace it.
(delete-selection-mode)

;; return not only goes to the next line, but indents according to major mode rules
(global-set-key (kbd "RET") 'newline-and-indent)

;; make the kill ring large, delete until end of line line on c-S-backspace
(setq kill-ring-max 5000;
      kill-whole-line t;
      )

;; Bind global indent of the buffer or region
(global-set-key (kbd "C-c i") 'indent-region-or-buffer)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Whitespace handling
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; uncomment this and comment out ws-butler if you
;; really want to nuke the entire file and get rid
;; of all whitespace errors in it. This will bloat
;; your files commit size and makes it hard
;; to see what are functionality changes versus
;; what are formatting changes, and is not recommended.
;;
;; If you want to clean a file you can always
;; do so explicitly via M-x whitespace-cleanup
;;
;;(global-whitespace-cleanup-mode)

;; show whitespace in diff mode
(add-hook 'diff-mode-hook (lambda()
                            (setq-local whitespace-style
                                        '(face
                                          tabs
                                          tab-mark
                                          spaces
                                          space-mark
                                          trailing
                                          indentation::space
                                          indentation::tab
                                          newline
                                          newline-mark))
                            (whitespace-mode 1)))

;; whitespace butler cleans the whitespace on each line you edit.
;; comment this out if you turn on global-whitespace-cleanup-mode
(use-package ws-butler
  :init
  (add-hook 'prog-mode-hook 'ws-butler-mode)
  (add-hook 'text-mode 'ws-butler-mode)
  (add-hook 'fundamental-mode 'ws-butler-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Editing minor mode packages that alter the display or provide other feedback
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; volatile-highlights shows what you changed in the buffer until the next keypress
(use-package volatile-highlights
  :init
  (volatile-highlights-mode t))

;; treat undo buffer as a tree of changes instead of linear. See undo-tree-visualizer.
(use-package undo-tree
  :init
  (global-undo-tree-mode 1))

;; An abbreviation template system for emacs. Type an abbreviation and it expands it.
(use-package yasnippet
  :defer t
  :init
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (setq lsp-enable-snippet t)
   )

;; A minor mode which displays current match and total matches in the mode line
;; when a search is being performed.
(use-package anzu
  :init
  (global-anzu-mode)
  (global-set-key (kbd "M-%") 'anzu-query-replace)
  (global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp))

;; Allows us to edit multiple occurrences of the same pattern simultaneously
(use-package iedit
  :bind (("C-;" . iedit-mode))
  :init
  (setq iedit-toggle-key-default nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Generic code completion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; A code completion, syntax checker, etc. engine that uses the LSP to
;; talk to completion servers.
;; https://github.com/emacs-lsp/lsp-mode
(use-package lsp-mode
  :ensure t
  :hook (;; Python on Linux/mac OS is pyls (python language server)
         (python-mode . lsp)
         ;; Rust RLS (Rust Language Server) https://github.com/rust-lang/rls
         ;;(rust-mode . lsp)
         ;; Bash uses bash-language-server
         ;; https://github.com/mads-hartmann/bash-language-server
         (shell-mode . lsp)
         )
  :init
  ;; Disable yasnippet. We re-enable when yasnippet is loaded.
  (defvar lsp-enable-snippet nil)
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


  ;; Use as C++ completer if desired. We use the clangd backend
  (add-hook 'c-mode-common-hook 'lsp-mode)

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

  ;; Set keybindings
  (local-set-key (kbd "C-c y n") 'lsp-rename)
  (local-set-key (kbd "C-c y o") 'lsp-restart-workspace)
  (local-set-key (kbd "C-c y c") 'lsp-disconnect)
  (local-set-key (kbd "C-c f") 'lsp-format-region)
  )

(provide 'setup-editing)
