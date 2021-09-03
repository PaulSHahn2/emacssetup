;;; setup-editing --- Summary:
;;; Commentary:
;; Emacs 26 and newer
;;; Code:

;;;;;;;;;;;;;;;;;;;
;; markdown support
;;;;;;;;;;;;;;;;;;;;
(use-package markdown-mode
  :mode ("\\.md'" "\\.markdown\\'")
  :config
  (setq markdown-css-paths '("/home/paul/development/projects/cpp/cpp-code-standards/css/document.css"))
  ;; custom markdown pandoc settings
(setq markdown-command
   (concat "/usr/bin/pandoc"
           " --from=markdown --to=html --standalone --mathjax --highlight-style=tango --metadata pagetitle='markdown-preview-mode'") )
)

(use-package markdown-preview-mode
  :config
    (add-to-list 'markdown-preview-stylesheets "https://raw.githubusercontent.com/PaulSHahn/cpp-code-standards/master/css/document.css")
)

(add-hook 'markdown-mode-hook
          (lambda ()
            (set-fill-column 80)))


(message "setup-markdown complete")

(provide 'setup-markdown)
