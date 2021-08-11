;;; initfile --- Summary: General display & appearance settings
;;; Commentary:
;; Emacs 26 and newer
;;; Code:


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General display variables and options
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; maximize on start
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; enable line number and column number
(setq column-number-mode t)
(setq line-number-mode t)
;; enable visible bell
(setq visible-bell 1)
;; syntax high lighting
(setq global-font-lock-mode t)
(setq transient-mark-mode t)
;; highlight parens
(show-paren-mode 1)
;; no scroll bar, menu, tool bar.
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
;; display the current time
(display-time)

;; only use this if you have compiled from git head with option --with-native-compilation
(setq comp-deferred-compilation t)

;; highlight search results by default
(setq-default search-highlist t)

;; calendar information
(setq calendar-latitude 33.43)
(setq calendar-longitude -112.02)
(setq calendar-location-name "Phoenix, AZ")
(setq calendar-daylight-savings-ends nil)
(setq calendar-daylight-savings-starts nil)

;; ediff mode split
(setq ediff-split-window-function 'split-window-horizontally)

;; move the mouse coursor
(mouse-avoidance-mode 'cat-and-mouse)

;; Don't disable downcase region and upcase region.
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
;; Don't display the startup message
(setq inhibit-startup-message t)


;; highlight trailing whitespace with red characters
(add-hook 'prog-mode-hook
	  (lambda () (interactive)
	    (setq show-trailing-whitespace 1)))

;; use space to indent by default
(setq-default indent-tabs-mode nil)

;; set appearance of a tab that is represented by 3 spaces
(setq-default tab-width 3)

;; setup GDB
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )

;; company
(use-package company
  :ensure t
  :diminish company-mode
  :config
  :init
  (global-company-mode 1)
  (delete 'company-semantic company-backends))

;; Add icons to code completion when using the GUI client.
(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))

;; byte compile init setup for faster startup.
(defvar my:byte-compile-init t)

;; asyncronous processing
(use-package async
  :ensure t)

;; let the windows be numbered for easy access. meta-# key
(use-package window-numbering
  :ensure t
  :config
  (eval-when-compile
    ;; Silence missing function warnings
    (declare-function window-numbering-mode "window-numbering.el"))
  (window-numbering-mode t)
  )

;; icon support
(use-package all-the-icons)
(use-package all-the-icons-completion)
(add-hook  'dired-mode-hook `all-the-icons-dired-mode)

(provide 'setup-general)
