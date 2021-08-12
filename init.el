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
   '(company-c-headers ivy-prescient lsp-ivy prescient python-mode rainbow-delimiters which-key immaterial-theme leuven-theme solarized-theme organic-green-theme zenburn-theme flyspell-correct-ivy counsel-gtags counsel-projectile counsel all-the-icons-ivy-rich ivy company-ansible dap-mode dired-sidebar bazel all-the-icons-completion-mode all-the-icons-dired all-the-icons-completion lsp-jedi elpy helm-apt cmake-font-lock ccls bazel-mode git-timemachine flyspell-correct-helm modern-cpp-font-lock projectile-sift magit magithub git-gutter whitespace-cleanup-mode prettier-js tide js2-mode json-mode pycoverage projectile anzu helm helm-swoop helm-projectile company company-box helm-company iedit markdown-mode markdown-mode+ markdown-preview-mode use-package volatile-highlights ws-butler undo-tree py-autopep8 flycheck flycheck-coverity flycheck-tip flycheck-yamllint flymake-yaml yaml-mode lsp-mode lsp-ui moder-cpp-font-lock window-numbering py-yapf yapfify cmake-mode))
 '(safe-local-variable-values
   '((projectile-project-compilation-cmd . "invoke quality.lint")
     (projectile-project-install-cmd . "invoke build.install-local")
     (projectile-project-package-cmd . "invoke build.release")
     (\,
      (projectile-project-compilation-cmd . "invoke quality.lint"))
     (projectile-project-test-cmd . "invoke quality"))))


(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/custom")
;; display settings, themes, timezone, location info
(require 'setup-general)
;; helm completion control
;;(require 'setup-helm)
;; ivy counsel completion control
(require 'setup-ivy-counsel)
;; general settings that apply to editing all buffers
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
;; on windows machines, uncomment this for specific windows settings.
;;(require 'setup-windows)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fill-column-indicator ((t (:foreground "gray80" :weight normal))))
 '(multi-magit-repo-heading ((t (:inherit magit-section-heading :box nil))))
 '(speedbar-selected-face ((t (:foreground "#008B45" :underline t)))))
