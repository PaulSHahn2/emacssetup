;;; setup-exwm.el --- Summary: Exwm window manager setup.
;;; Commentary:
;; Emacs 27 and newer
;;; Code:

;; this should be a built-in as long as you compiled with dbus mode
(require 'notifications)
;; builtin for free desktop support
(require 'xdg)

;; possible free desktop locations for desktop configuration files
(defvar-local exwmsetup/xdg-app-directories
  (mapcar (lambda (dir) (expand-file-name "applications" dir))
          (xdg-data-dirs)))

;; hash table with xdg application data stored by window class name
(defvar-local exwmsetup/xdg-installed-application-information-hash (make-hash-table :test 'equal :size 500))

;; hash table holds app category to workspace index affiliation
(defvar-local exwmsetup/xdg-category-workspace-hash (make-hash-table :test 'equal :size 15))

(defun exwmsetup/goto-previous-workspace ()
  "Go to the frame one less than current by index, or wrap to max frame if first frame."
  (interactive)
  (defvar-local moveto-workspace 0)
  (if (= exwm-workspace-current-index 0)
       (setq moveto-workspace (- exwm-workspace-number 1))
    (setq moveto-workspace (- exwm-workspace-current-index 1))
   )
  (exwm-workspace-switch-create moveto-workspace)
  (notifications-notify :title (format "workspace %d" exwm-workspace-current-index) :timeout 1000)
)

(defun exwmsetup/goto-next-workspace ()
  "Go to the next frame by index, or wrap to 0 if last frame."
  (interactive)
  (defvar-local moveto-workspace 0)
  (if (= exwm-workspace-current-index (- exwm-workspace-number 1))
      (setq moveto-workspace 0)
    (setq moveto-workspace (+ exwm-workspace-current-index 1))
  )
  (exwm-workspace-switch-create moveto-workspace)
  (notifications-notify :title (format "workspace %d" exwm-workspace-current-index) :timeout 1000)
)

(defun exwmsetup/get-xdg-desktop-file-data (desktop-file)
  "For a given DESKTOP-FILE, get the xdg data in the file and add to exwmsetup/xdg-installed-application-information-hash with a key of classname or executable name."
  ;;(message "Found xdg desktop application file: %s" desktop-file)
  (setq local-temp-hash (xdg-desktop-read-file desktop-file))
  (setq local-class-name (elt (split-string (gethash "StartupWMClass" local-temp-hash (gethash "Exec" local-temp-hash "!KEY-MISSING")) " " 1) 0))
  (unless (string-equal local-class-name  "!KEY-MISSING")
    (puthash (elt (last (split-string local-class-name "/" 1)) 0) local-temp-hash exwmsetup/xdg-installed-application-information-hash)))

(defun exwmsetup/setup-xdg-installed-app-info ()
  "Get a hash table with xdg data for all installed x-windows applications.

The key is the exwm-class-name and the value is hash table of xdg data."

  (mapc 'exwmsetup/get-xdg-desktop-file-data
        (mapcan (lambda (current-dir) (directory-files current-dir 1 "\.desktop$"))
                (seq-filter 'file-directory-p exwmsetup/xdg-app-directories))))

(defun exwmsetup/get-xdg-desktop-category-list (window-class-name)
  "Get the list of xdg categories that the application WINDOW-CLASS-NAME belongs too."
  (if (hash-table-p (gethash window-class-name exwmsetup/xdg-installed-application-information-hash nil) )
      (split-string (gethash "Categories" (gethash window-class-name exwmsetup/xdg-installed-application-information-hash) "Unknown;") ";" 1)
  '("Unknown")))

(defun exwmsetup/setup-category-workspace-affiliation ()
  "Populate the xdg-category-workspace-hash table.

The key is the xdg application category and the value is the workspace that applications belonging to that category should be sent to."
  (puthash "Development" 1 exwmsetup/xdg-category-workspace-hash)
  (puthash "Network" 2 exwmsetup/xdg-category-workspace-hash)
  (puthash "AudioVideo" 3 exwmsetup/xdg-category-workspace-hash)
  (puthash "Audio" 3 exwmsetup/xdg-category-workspace-hash)
  (puthash "Video" 3 exwmsetup/xdg-category-workspace-hash)
  (puthash "Graphics" 3 exwmsetup/xdg-category-workspace-hash)
  (puthash "Game" 3 exwmsetup/xdg-category-workspace-hash)
  (puthash "Office" 4 exwmsetup/xdg-category-workspace-hash)
  (puthash "Education" 4 exwmsetup/xdg-category-workspace-hash)
  (puthash "Science" 4 exwmsetup/xdg-category-workspace-hash)
  (puthash "System" 5 exwmsetup/xdg-category-workspace-hash)
  (puthash "Settings" 5 exwmsetup/xdg-category-workspace-hash)
  (puthash "Utility" 5 exwmsetup/xdg-category-workspace-hash)
  (puthash "Unknown" 5 exwmsetup/xdg-category-workspace-hash)
  )

(defun exwmsetup/configure-window-by-app-category ()
  "When an x windows program is started, compare each of its categories to the workspace affiliation hash.

If a category match is found, start the app in the specified
workspace. If no match is found, start the app on workspace 5."
  (interactive)
  (unless (string-equal exwm-class-name "ibus-ui-gtk")
  (cl-loop for category in (exwmsetup/get-xdg-desktop-category-list (downcase exwm-class-name))
         do (setq local-workspace (gethash category exwmsetup/xdg-category-workspace-hash nil))
         until local-workspace
         )
  (exwm-workspace-move-window local-workspace)
  (notifications-notify :title (format "Opening %s on workspace %d" exwm-class-name local-workspace) :timeout 4000)))

;;; the following functions are based on code included
;;; in Systemcrafters' emacs from scratch series "Emacs Desktop Environment"

(defun exwmsetup/dunstctl (command)
  "Run a dunstcntrl command to control the dunst notifier."
  (start-process-shell-command "dunstctl" nil (concat "dunstctl " command))
)

(defun exwmsetup/exwm-update-x-windows-buffer ()
  "Update the buffer name to include the X-window class-name and title."
  (exwm-workspace-rename-buffer (format "%s: %s" exwm-class-name exwm-title))
)

(defun exwmsetup/run-in-background (command)
  "Run a daemon program in the background."
  (let ((command-parts (split-string command "[ ]+")))
    (apply #'call-process `(,(car command-parts) nil 0 nil ,@(cdr command-parts))))
)

(defun exwmsetup/set-wallpaper ()
  "Set the wallpaper that shown when transparency is on using the feh program."
  (interactive)
  ;; If this goes wonky, change nill to "feh" and view debug output in the feh buffer
  ;; Something in exwm blocks imagemagick conversion when starting up, so give this a long conversions timeout.
  (if (get-process "feh")
      (message "set wallpaper already in progress.")
    (start-process-shell-command
     "feh" nil "/usr/bin/feh --conversion-timeout 60 --bg-scale /usr/share/wallpapers/moonlight/contents/images/1920x1080.svg")
    (message "Set wallpaper requested"))
)

(defun exwmsetup/update-displays ()
  "Update the display in-case we have a kvm or docking event."
  ;; this is not really stanble, causes havoc
  ;;(exwmsetup/run-in-background "autorandr --change --force")
  (exwmsetup/run-in-background "autorandr --change")
  (exwmsetup/set-wallpaper)
  (message "Display config: %s"
           (string-trim (shell-command-to-string "autorandr --current"))
  )
)

(defun exwmsetup/exwm-init-hook ()
  "When exwm is initializes, perform these tasks to customize our desktop environment."
  (exwmsetup/run-in-background "dunst -conf ~/.emacs-d/skel/dunst.conf")
  (exwmsetup/run-in-background "ssh-add")
  (exwmsetup/run-in-background "nm-applet")
  (exwmsetup/run-in-background "pasystray")
  (exwmsetup/run-in-background "update-notifier")
  (exwmsetup/setup-category-workspace-affiliation)
  (exwmsetup/setup-xdg-installed-app-info)
  (message "exwmsetup/exwm-init-hook finished")
)

;; any newly created window frames will be set to this transparency.
(add-to-list 'default-frame-alist '(alpha . (90 . 30)))

(use-package exwm
  :init
  (require 'exwm-randr)
  (require 'exwm-systemtray)
  :config
  (message "Adding hooks")
  ;; when the window class updates, reset the buffer name
  (add-hook 'exwm-update-class-hook #'exwmsetup/exwm-update-x-windows-buffer)
  ;; when the window title updates, reset the buffer name
  (add-hook 'exwm-update-title-hook #'exwmsetup/exwm-update-x-windows-buffer)
  ;; manage windows as they are created
  (add-hook 'exwm-manage-finish-hook #'exwmsetup/configure-window-by-app-category)
  ;; other exwm startup configuration
  (add-hook 'exwm-init-hook #'exwmsetup/exwm-init-hook)
  (setq exwm-systemtray-height 32)
  (message "setting workspace monitor plist")
  (setq exwm-randr-workspace-monitor-plist '(0 "HDMI-0"
                                              1 "DP-3"
                                              2 "DP-5"))
  ;;(message "using popup minibuffer")
  ;;(setq exwm-workspace-minibuffer-position 'top)
  (message "set mouse point to follow workspace selection")
  (setq exwm-workspace-warp-cursor t)

  (message "setting input global keys")
  (setq exwm-input-global-keys
        ;;; super key is not available in VM's though... :(
        `(
          ([?\s-r] . exwm-reset)
          ([s-left] . exwmsetup/goto-previous-workspace)
          ([s-right] . exwmsetup/goto-next-workspace)
          ([?\s-p] . (lambda() (interactive) (exwmsetup/dunstctl "history-pop")))
          ([?\s-d] . (lambda() (interactive) (exwmsetup/dunstctl "close-all")))
          ([s-up] . windmove-up)
          ([s-down] . windmove-down)
          ([?\s-w] . exwm-workspace-switch)
          ,@(mapcar (lambda (i)
            `(,(kbd (format "s-%d" i)) .
              (lambda()
                (interactive)
                (exwm-workspace-switch-create ,i)
                (notifications-notify :title (format "workspace %d" exwm-workspace-current-index) :timeout 1000))))
                    (number-sequence 0 9))
          )
  )
  (message "setting total number of available work-spaces")
  ;; We will create X workspaces to organize our work by purpose.
  ;; Workspaces are roughly equivalent to emacs frames.
  ;; We can rotate these workspaces between our displays, which we
  ;; want to default to showing workspace 0-2 at startup, since we have
  ;; 3 displays. The center display is often shared via a KVM switch with another machine.
  ;; Workspace 0 (left): org-mode windows. Mail inside emacs, eventually. emacs buffers
  ;; Workspace 1 (center): emacs programming buffers, xdg category Development
  ;; Workspace 2 (right): Browsers, Thunderbird mail reader, IM chat xdg categories Network
  ;; Workspace 3 (not shown): xdg categories Audio, Video, AudioVideo, Graphics, Game
  ;; Workspace 4 (not shown): xdg categories Office, Education, Science
  ;; Workspace 5 (not shown): Private, xdg categories System, Settings, Utility
  (setq exwm-workspace-number 6)
  (message "enabling randr")
  (exwm-randr-enable)
  (message "setup xrandr screen settings")
  ;; this doesn't work on home machine
  ;;(exwmsetup/update-displays)
  (start-process-shell-command
  "xrandr" nil "xrandr --output DVI-D-0 --off --output HDMI-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-0 --off --output DP-1 --off --output DP-2 --off --output DP-3 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-4 --off --output DP-5 --mode 1920x1080 --pos 3840x0 --rotate normal")
  (add-hook 'exwm-randr-screen-change-hook #'exwmsetup/update-displays)
  (message "exwm enabling systemtray")
  (exwm-systemtray-enable)
  (message "calling exwm init")
  (exwm-init)
)

;; media key bindings
(use-package desktop-environment
  :after exwm
  :config (desktop-environment-mode)
)

;; go ahead and start up a server that exits when we exit
;; this is easier than using --daemon when we are the window manager as well.
(server-start)

(message "setup-exwm complete")

(provide 'setup-exwm)
