;;; setup-windows.el --- Summary: setup Microsoft Windows specific configurations
;;; Commentary:
;;; Emacs 28 and newer
;;; This may not work as it hasn't been used in awhile.
;;; Code:

;; On windows, use hunspell
(setq-default ispell-program-name "hunspell")
(custom-set-variables '(pandoc-binary "c:/Users/phahn01/AppData/Local/Pandoc/pandoc.exe"))
;;(custom-set-variables '(markdown-command "c:/Users/phahn01/AppData/Local/Pandoc/pandoc.exe"))
(setq markdown-command "c:/Users/phahn01/AppData/Local/Pandoc/pandoc.exe")


;; On Windows, set default to unix line endings.
(setq default-buffer-file-coding-system 'utf-8-unix)

(message "setup-windows complete")

(provide 'setup-windows)
