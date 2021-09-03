;;; initfile --- Summary:
;;; Commentary:
;; Emacs 26 and newer
;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-noise-macro-names '("constexpr"))
 '(custom-safe-themes
   '("aff12479ae941ea8e790abb1359c9bb21ab10acd15486e07e64e0e10d7fdab38" "a44bca3ed952cb0fd2d73ff3684bda48304565d3eb9e8b789c6cca5c1d9254d1" "db5e88605d0ed6a6fe14ca181f8450250a0f98e113714debaf1881d6bc0a9e01" "87de2a48139167bfe19e314996ee0a8d081a6d8803954bafda08857684109b4e" "409e4d689f1e29e5a18f536507e6dc760ee9da76dc56481aaa0696705e6be968" "d94a55a07623ee474ddb4a0a5dca9a250ea4dcebe554249ce305560c3340ec57" "3d4df186126c347e002c8366d32016948068d2e9198c496093a96775cc3b3eaa" "e6df46d5085fde0ad56a46ef69ebb388193080cc9819e2d6024c9c6e27388ba9" default))
 '(package-selected-packages
   '(treemacs-all-the-icons org-tree-slide smart-mode-line desktop-environment exwm diminish async org-vcard window-number sudo-edit rainbow-mode org-contacts org-contrib org-plus-contrib markdown-live-preview-mode org-bullets org-caldav company-c-headers ivy-prescient lsp-ivy prescient python-mode rainbow-delimiters which-key immaterial-theme leuven-theme solarized-theme organic-green-theme zenburn-theme flyspell-correct-ivy counsel-gtags counsel-projectile counsel all-the-icons-ivy-rich ivy company-ansible dap-mode dired-sidebar bazel all-the-icons-completion-mode all-the-icons-dired all-the-icons-completion lsp-jedi elpy cmake-font-lock ccls bazel-mode git-timemachine modern-cpp-font-lock projectile-sift magit magithub git-gutter whitespace-cleanup-mode prettier-js tide js2-mode json-mode pycoverage projectile anzu company company-box iedit markdown-mode markdown-mode+ markdown-preview-mode use-package volatile-highlights ws-butler py-autopep8 flycheck flycheck-coverity flycheck-tip flycheck-yamllint flymake-yaml lsp-mode lsp-ui moder-cpp-font-lock py-yapf yapfify cmake-mode)))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/custom")
;; You must create this file and put your secrets in it. An example is provided in ./skel/setup-secrets.el.
(load-library "~/.emacs.d/custom/setup-secrets.el.gpg")
;; unlock gpg encrypted secrets
(require 'setup-secrets)
;; display settings, themes, timezone, location info
(require 'setup-general)
;; helm completion control, no longer enabled by default in favor of ivy
;;(require 'setup-helm)
;; ivy counsel completion control
(require 'setup-ivy-counsel)
;; general editing settings
(require 'setup-editing)
;; general programming IDE settings
(require 'setup-programming)
;; spell correction configuration
(require 'setup-spelling)
;; git specific configuration
(require 'setup-git)
;; projectile development project management configuration
(require 'setup-projectile)
;; bash shell specific configuration
(require 'setup-shell)
;; markdown and restructure editing specific configuration
(require 'setup-markdown)
;; Python specific configuration
(require 'setup-python)
;; Javascript and JSON specific configuration
(require 'setup-javascript)
;; C and C++ specific configuration
(require 'setup-c)
;; org mode
(require 'setup-orgmode)
;; themes
(require 'setup-theme)
;; on windows machines, load this for specific windows settings and over-rides.
(when (string-equal system-type "windows-nt")
  (message "Running on Windows OS... loading windows configuration")
  (require 'setup-windows)
)

;; email, work in progress still
;; (require setup-mail.el)

;; Only when a GNU Linux os and XDG_CURRENT_DESKTOP is set and
;; is equal to EXWM, do we require this... otherwise skip it.
(when (string-equal system-type "gnu/linux")
  (when (string-equal (getenv "XDG_CURRENT_DESKTOP") "exwm")
    (message "window manager mode requested... loading exwm")
    (require 'setup-exwm)
  )
)

(message "init.el complete")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fill-column-indicator ((t (:foreground "gray80" :weight normal))))
 '(multi-magit-repo-heading ((t (:inherit magit-section-heading :box nil))))
 '(speedbar-selected-face ((t (:foreground "#008B45" :underline t)))))
