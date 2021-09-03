;;; setup-editing.el --- Summary: Setup general editing settings.
;;; Commentary:
;; Emacs 28 and newer
;;; Code:

;; move the mouse cursor when emacs cursor collides with it
(mouse-avoidance-mode 'cat-and-mouse)

;; highlight trailing whitespace with red characters
(add-hook 'prog-mode-hook
	  (lambda () (interactive)
	    (setq show-trailing-whitespace 1)))

;; no tabs by default, use space to indent by default
;; modes can turn this on per mode
;; if they require spaces in their content, such as makefile-mode
(setq-default indent-tabs-mode nil)

;; Default column fill is 160, not 80.
(setq-default fill-column 160)

;; various default variables
(setq global-mark-ring-max 5000;
      mark-ring-max 5000;
      mode-require-final-newline t;
      tab-width 3;
      )

;; set appearance of a tab that is represented by 3 spaces
(setq-default tab-width 3)

;; prefer utf8 to ascii
(set-charset-priority 'unicode)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))
;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; Don't disable downcase region and upcase region, I use these.
;; I am not sure how or what or why they now get disabled.
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

;; An abbreviation template system for emacs. Type an abbreviation and it expands it.
(use-package yasnippet
  :defer t
  :init
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (setq lsp-enable-snippet t))

;; Allows us to edit multiple occurrences of the same pattern simultaneously
(use-package iedit
  :bind (("C-;" . iedit-mode))
  :init
  (setq iedit-toggle-key-default nil))


;; don't bind this to a key, just call it to edit a file as root
(use-package sudo-edit)

;; search for match among beginning of words, narrow to tree
;; somewhat faster than swiper/i-search
(use-package avy
  :bind
  ("C-:" . avy-goto-char)
)

(message "setup-editing complete")

(provide 'setup-editing)
