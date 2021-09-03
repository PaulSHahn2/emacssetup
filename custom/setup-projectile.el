;;; setup-projectile.el --- Summary: Setup Projectile configuration
;;; Commentary:
;; Emacs 28 and newer
;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package: projectile and helm projectile
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; projectile recognizes various types of development projects, such as Maven, automake, cmake, etc.
(use-package projectile
  :init
  (projectile-mode 1)
  :config
  (setq projectile-enable-caching t)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  ;; You could of used the default if your super is not captured by host OS
  ;;(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  ;; Make projectile aware of CPP Bazel projects.
  (projectile-register-project-type
   'bazel '("WORKSPACE")
   :compile "bazel build --verbose_failures --compilation_mode=dbg -s //..."
   :test "bazel test --test_output=all //..."
   :run "bazel run"
   :test-suffix ".test")
  ;; Make projectile aware of qmake project files FIXME: some pro files are qmake, figure this out.
  (projectile-register-project-type 'qmake '("Xsaitekpanels.pro")
                                    :compile "make -j"
                                    :test "make test"
                                    :configure "qmake -spec linux-g++")
  ;; search the following locations for projects. Different machines have different configurations and projects going.
  (setq projectile-project-search-path '("~/development/projects/" "~/redhat/DEVEL/"))
)

(use-package counsel-projectile
  :init
  (setq projectile-completion-system 'ivy)
)

;; comment out counsel-projectile and use this if a helm user.
;;(use-package helm-projectile
;;  :init
;;  (helm-projectile-on)
;;  (setq projectile-completion-system 'helm))

(message "setup-projectile complete")

(provide 'setup-projectile)
