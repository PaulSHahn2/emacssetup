;;; setup-ivy-counsel.el --- Summary: Setup ivy counsel and swiper
;;; Commentary:
;; Emacs 28 and newer
;;; Code:

(use-package counsel
  :after ivy
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config (counsel-mode)
)

(use-package ivy
  :defer 0.1
  :diminish
  :config (setq ivy-use-virtual-buffers t ivy-count-format "%d/%d ")
  :init(ivy-mode 1))

(use-package all-the-icons-ivy-rich
  :after ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))
(use-package ivy-rich
  :after ivy
  :ensure t
  :init(ivy-rich-mode 1))

(use-package swiper
  :config
  (global-set-key "\C-s" 'swiper)
  (global-set-key "\C-r" 'swiper-backward)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "M-y") 'counsel-yank-pop)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "<f2> j") 'counsel-set-variable)
  (global-set-key (kbd "C-x b") 'ivy-switch-buffer)
  (global-set-key (kbd "C-c v") 'ivy-push-view)
  (global-set-key (kbd "C-c V") 'ivy-pop-view)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c L") 'counsel-git-log)
  (global-set-key (kbd "C-c k") 'counsel-rg)
  (global-set-key (kbd "C-c m") 'counsel-linux-app)
  (global-set-key (kbd "C-c n") 'counsel-fzf)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-c J") 'counsel-file-jump)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "C-c b") 'counsel-bookmark)
  (global-set-key (kbd "C-c d") 'counsel-descbinds)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c o") 'counsel-outline)
  (global-set-key (kbd "C-c t") 'counsel-load-theme)
  (global-set-key (kbd "C-c F") 'counsel-org-file))

(use-package lsp-ivy
  :after lsp)

(use-package lsp-treemacs
  :after lsp)

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  (setq prescient-persist-mode 1)
  (ivy-prescient-mode 1)
)

(message "setup-ivy-counsel complete")
(provide 'setup-ivy-counsel)
