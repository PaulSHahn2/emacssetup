;;; setup-editing --- Summary:
;;; Commentary:
;; Emacs 26 and newer
;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package: projectile and helm projectile
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; projectile recognizes various types of development projects, such as Maven, automake, cmake, etc.
(use-package projectile
  :init
  (projectile-global-mode)
  :config
  (setq projectile-enable-caching t)
  (setq projectile-completion-system 'ivy)
  )

;; still using the old map until we reprogram the keyboard
;;(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(use-package counsel-projectile)

;;(use-package helm-projectile
;;  :init
;;  (helm-projectile-on)
;;  (setq projectile-completion-system 'helm)
;;  (setq projectile-indexing-method 'alien))

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
(setq projectile-project-search-path '("~/development/projects/" "~/redhat/DEVEL/" "~/python-projects/"))

(provide 'setup-projectile)
