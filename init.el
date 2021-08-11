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
 '(package-selected-packages
   '(dap-mode dired-sidebar bazel all-the-icons-completion-mode all-the-icons-dired all-the-icons-completion lsp-jedi elpy helm-apt cmake-font-lock ccls bazel-mode git-timemachine flyspell-correct-helm modern-cpp-font-lock projectile-sift magit magithub git-gutter whitespace-cleanup-mode prettier-js tide js2-mode json-mode pycoverage projectile anzu helm helm-swoop helm-projectile company company-box helm-company iedit markdown-mode markdown-mode+ markdown-preview-mode use-package volatile-highlights ws-butler undo-tree py-autopep8 flycheck flycheck-coverity flycheck-tip flycheck-yamllint flymake-yaml yaml-mode lsp-mode lsp-ui moder-cpp-font-lock window-numbering py-yapf yapfify cmake-mode))
 '(safe-local-variable-values
   '((projectile-project-compilation-cmd . "invoke quality.lint")
     (projectile-project-install-cmd . "invoke build.install-local")
     (projectile-project-package-cmd . "invoke build.release")
     (\,
      (projectile-project-compilation-cmd . "invoke quality.lint"))
     (projectile-project-test-cmd . "invoke quality"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/custom")
;; display settings, themes, timezone, location info
(require 'setup-general)
;; helm completion control
(require 'setup-helm)
;; general settings that apply to editing all buffers
(require 'setup-editing)
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
;; on windows machines, uncomment this for specific windows settings.
;;(require 'setup-windows)
