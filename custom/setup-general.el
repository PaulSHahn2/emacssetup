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
;; display the current time but not load average
(setq display-time-default-load-average nil)
(display-time)

;; Ask y or n instead of yes or no
(defalias 'yes-or-no-p 'y-or-n-p)

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

;; ediff mode split and add -diff option to start emacs with two buffers in ediff mode
(use-package ediff
  :config
  (setq ediff-split-window-function 'split-window-horizontally)
  (defun my/command-line-diff (switch)
    (setq initial-buffer-choice nil)
    (let ((file1 (pop command-line-args-left))
      (file2 (pop command-line-args-left)))
      (ediff file1 file2)))
  ;; show the ediff command buffer in the same frame
  (add-to-list 'command-switch-alist '("-diff" . my/command-line-diff))
)

;; Don't display the startup message
(setq inhibit-startup-message t)

;; asyncronous processing
(use-package async)

;; company
(use-package company
  :after lsp-mode
  :hook (prog-mode . company-mode)
  :bind (:map company-active-map
              ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
        ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 1.0)
)

;; Add icons to code completion when using the GUI client.
(use-package company-box
  :hook (company-mode . company-box-mode))

;; Support Ansible YAML file options completions
(use-package company-ansible
  :config
  (add-to-list 'company-backends 'company-ansible)
)

;; byte compile init setup for faster startup.
(defvar my:byte-compile-init t)

;; let the windows be numbered for easy access. meta-# key accesses
;; the window matching the number in current frame. The modeline displays
;; the windows number
(use-package window-number
  :config
  (window-number-mode 1)
  (window-number-meta-mode 1)
)

;; icon support
(use-package all-the-icons)
(use-package all-the-icons-completion)
(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode)
  )

;; which key
(use-package which-key
  :defer 0
  :diminish which-key-mode
  :init
  (which-key-mode)
  :config
  (setq which-key-idle-delay 1))

;; provide a way to kill all open buffers
(defun nuke-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list))
)

;; We need a more compact modeline.
;; Each minor mode wants to load status messages into the
;; limited screen real-estate that exists in the modeline.
;; Most of these minor modes don't display anything useful
;; they just tell you the minor mode is running.
;; We get rid of the info for minor modes we don't care
;; to see, using diminish. The modes are still running,
;; but they no longer put clutter in the modeline.
(use-package diminish
  :after company-box
  :config
  (diminish 'which-key-mode)
  (diminish 'git-gutter-mode)
  (diminish 'company-box-mode)
  (diminish 'flyspell-mode)
  (diminish 'flyspell-prog-mode)
  (diminish 'flycheck-mode)
  (diminish 'yas-minor-mode)
  (diminish 'auto-revert-mode)
  (diminish 'volatile-highlights-mode)
  (diminish 'ws-butler-mode)
  (diminish 'counsel-mode)
  (diminish 'company-mode)
  (diminish 'projectile-mode)
  (diminish 'ivy-mode)
  (diminish 'rainbow-mode)
  (diminish 'outline-minor-mode)
  (diminish 'eldoc-mode)
  (diminish 'desktop-environment-mode)
)

(message "setup-general complete")

(provide 'setup-general)
