;;; initfile --- Summary:
;;; Commentary:
;; Emacs 26 and newer
;;; Code:

;; NOTE: Don't use CEDET or semantic. They are in lisp and slower.

;; ccls lsp server provides data for C/C++/Objective C via clang
;; You must have ccls & clang installed.
;;(setq lsp-prefer-flymake nil)
;;(setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
(use-package ccls
  :ensure t
  :config
  (setq ccls-executable "ccls")
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))

;; hs-minor-mode for folding source code
(add-hook 'c-mode-common-hook 'hs-minor-mode)

;; Available C styles:
;; “gnu”: The default style for GNU projects
;; “k&r”: What Kernighan and Ritchie, the authors of C used in their book
;; “bsd”: What BSD developers use, aka “Allman style” after Eric Allman.
;; “whitesmith”: Popularized by the examples that came with Whitesmiths C, an early commercial C compiler.
;; “stroustrup”: What Stroustrup, the author of C++ used in his book
;; “ellemtel”: Popular C++ coding standards as defined by “Programming in C++, Rules and Recommendations,” Erik Nyquist and Mats Henricson, Ellemtel
;; “linux”: What the Linux developers use for kernel development
;; “python”: What Python developers use for extension modules
;; “java”: The default style for java-mode (see below)
;; “user”: When you want to define your own style
(setq c-default-style "stroustrup" c-basic-offset 3)


;; company-c-headers
(use-package company-c-headers
  :ensure t
  :config
  (add-to-list 'company-backends 'company-c-headers)
  (add-to-list 'company-c-headers-path-system "/usr/include/")
  (add-to-list 'company-c-headers-path-system "/opt/rh/devtoolset-10/root/usr/include/")
  )
;;  (add-to-list 'company-c-headers-path-system "/usr/include/boost/")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup a more modern cpp parser for 2014 & 2017 CPP code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package modern-cpp-font-lock
  :ensure t
  :diminish modern-c++-font-lock-mode
  :init
  (eval-when-compile
      ;; Silence missing function warnings
    (declare-function modern-c++-font-lock-global-mode
                      "modern-cpp-font-lock.el"))
  :config
  (modern-c++-font-lock-global-mode t)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cc-mode settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package cc-mode
  :ensure t
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.tpp\\'" . c++-mode))
  (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
  (add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
  (add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
  (add-to-list 'auto-mode-alist '("\\.pc\\'" . c++-mode))
  :config
  (custom-set-variables '(c-noise-macro-names '("constexpr")))
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Note: For C++ we use flycheck with LSP mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :defer t
  :init
  (eval-when-compile
    ;; Silence missing function warnings
    ;(;declare-function global-flycheck-mode "flycheck.el"))
  :config
  ;; Turn flycheck on everywhere
  (global-flycheck-mode t)
  ;; There are issues with company mode and flycheck in terminal mode.
  ;; This is outlined at:
  ;; https://github.com/abingham/emacs-ycmd
  (when (not (display-graphic-p))
    (setq flycheck-indication-mode nil))
  )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cmake-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package cmake-mode
  :ensure t
  :mode ("CMakeLists.txt" ".cmake")
  :hook (cmake-mode . (lambda ()
                        (add-to-list 'company-backends 'company-cmake)))
  :config
  (use-package cmake-font-lock
    :ensure t
    :defer t
    :commands (cmake-font-lock-activate)
    :hook (cmake-mode . (lambda ()
                          (cmake-font-lock-activate)
                          (font-lock-add-keywords
                           nil '(("\\<\\(FIXME\\|TODO\\|BUG\\|DONE\\)"
                                  1 font-lock-warning-face t)))))
    )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Bazel-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (not (file-directory-p "~/.emacs.d/custom/"))
    (make-directory "~/.emacs.d/custom/"))
(if (not (file-exists-p "~/.emacs.d/custom/bazel-mode.el"))
    (url-copy-file
     "https://raw.githubusercontent.com/codesuki/bazel-mode/master/bazel-mode.el"
     "~/.emacs.d/custom/bazel-mode.el"))
(if (file-exists-p "~/.emacs.d/custom/bazel-mode.el")
    (use-package bazel-mode
      :mode ("WORKSPACE\\'")
      )
  )

;; Add support for C header files as C++ mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Use as C++ completer if desired. We use the clangd backend
(add-hook 'c-mode-common-hook 'lsp-mode)

(provide 'setup-c)
