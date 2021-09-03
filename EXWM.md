# exwm Window Manager Notes

This is still a work in progress. The notes are rough and so is the
scripting. Not a lisp programmer, so I am just slinging badly written lisp at my
setup until it works the way rat-poison used to.

## Install this stuff

So you need to install some stuff, on Lubuntu this is what I installed, other packages may be missing as well:

```bash
sudo apt-get install arandr picom feh playerctl brightnessctl pavucontrol pasystray suckless-tools xss-lock autorandr polybar dunst
```

## Switching Workspaces Quickly

I have created functions to switch workspaces/frames to the next and previous
workspace and bound them to super-left and super-right. Apparently there is a
package that does this called switch window, but I made my own in the
*setup-exwm.el* file before I found it. Mine sends a notification that is
displayed on the new workspace after switching, which I used to also do when I used the
*ratpoison* tiling window manager and found helpful. This notification shows the
index of the workspace/window/frame that you just switched into. The notification
goes away after a second and is displayed on top of the frame you switched into.

## Workspace Application Affinity

I wanted to use freedesktop (xdg) standard application categories to determine
what workspace to assign an application to. To me, this is better than a
hardcoded laundry list of applications, which always seem to change. *emacs* has
a builtin xdg package you can require. Counsel apparently wraps this for various
functionality, like *counsel-linux-app*. However, counsel doesn't easily expose
the internals of this for reuse, plus I suppose it is best not to depend on such
internals since they are subject to change. If I decide to go back to helm at
some point, they go away entirely.

So, I have a few functions that find all the desktop application configuration
files on the system using emacs *xdg*. Once found, I load the application
configuration values into a hash table called
*xdg-installed-application-information-hash*. The key to the hash is each
applications *exwm-class-name*. So we have a hash table with the class name for
a key that contains a value consisting of a hash table with all the xdg
application configuration values that were read in from the file.

I define another hash-table called *xdg-category-workspace-hash* that describes
the affinity between application categories and the desired workspace number
that they should be assigned to. The key is the xdg category name and the value
is the integer of the workspace they should be assigned to. So any application
belonging to a matching category should be opened in the specified workspace.

I bind function *exwmsetup/configure-window-by-app-category* to
*exwm-manage-finish-hook*. This function decides what workspace to send the
application to by getting the applications categories from
*xdg-installed-application-information-hash* and trying then searching for a
matching category in *xdg-category-workspace-hash*. If no matching category is
found, workspace 5 is used as the default workspace. The application is then
moved to the assigned workspace. After that, the function then displays a three
second notification saying what workspace the app went to. This displays in the
current workspace. You don't switch into the new workspace when you open the
application in it. Not switching is better for me, because most of the X
applications I open are intended to be used in the background and I don't
necessarily want to use them right away. Having the notification is handy in
case that workspace the app opens on is not visible-- I want to know
where the application went and that it was indeed opened.

Note the first category found in hash *xdg-category-workspace-hash* determines
the workspace location. Sometimes an application will have more than one
category that matches, but only the first matching one declared in the
applications desktop file will be used. If this is not the desired category, you
would have to edit the desktop file to reorder the categories, this is usually
package managed. Or you could add some hard code specific to the application
name to override the workspace.

## Misc Usage Notes

You can start apps with:

**M-& (async-shell-command):** This is kinda ghetto, but it works.
**M-x counsel-linux-app:** Lists apps, a bit more smooth, requires counsel.

Some somewhat handy commands:

**exwm-workspace-switch-to-buffer:** Go to the specified buffer from what is available.

**windmove-left/right/up/down:** Select the window to the left/right/up/down. Probably not useful as we have M-{NUM} to goto the buffer.
**windmove-swap-states-left/right/up/down:** Swap the buffer with the current one.
**exwm-floating-toggle-floating:** Toggle between tiled and floating window not in emacs tiled frame.
**exwm-layout-toggle-fullscreen:** Current buffer takes up entire window frame.

Like term-mode, there are two modes in exwm for non-native emacs x-managed
applications: line-mode and char-mode. C-c C-j and C-c C-k.

c-t-f: Toggle Making a window float.

## To use autorandr to adjust on the fly.

### When three displays are active, no kvm share, use autorandr to save results
autorandr --save triple-header

#### When two displays are active, with kvm share of one, use autorandr to save results
xrandr --output DP-3 --off
autorandr --save twin-monitors
