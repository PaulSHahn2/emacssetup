# Notes

This is still a work in progress. The notes are rough.

## Install this stuff
```
sudo apt-get install arandr picom feh playerctl brightnessctl pavucontrol pasystray suckless-tools xss-lock autorandr polybar dunst
```

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

