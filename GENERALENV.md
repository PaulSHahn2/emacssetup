# General emacs Environment Setup

What follows are instructions that I use to setup *emacs* in a GNU/Linux
environment. These are *emacs* settings that have to be setup in your GNU/Linux
shell and X-windows environments, they are not installed or configured as part of
this repository and don't contain *elisp* configuration code.

## Default editor

I set up *emacs* to be the default editor in my *bash* shell environment. I do
this by adding the following to file *~/.bashrc*:

```bash
export VISUAL='emacsclient -c --alternate-editor='
export EDITOR='emacsclient -t --alternate-editor='
alias e="${VISUAL}"
```

I like to run *emacs* in daemon mode (as a server/service). This is a better way
to run *emacs* on modern systems, since it shares resources between instances of
*emacs*. Not only is resource usage improved, each client instance will
integrate with the other instances when editing files. Thus multiple running
instances won't be able to trample and over-write the same file being visited by
other instances.

By default, *emacsclient* starts a new client that connects to the existing
*emacs* daemon running in the background. A daemon is another way of saying a
service, or server. The "--alternate-editor=" syntax above is awkward, but it
essentially means start up a new *emacs daemon* if the client could not find an
existing daemon to connect to.

Note that if you put an argument after the *=*, the behavior changes. When the
deamon isn't already running, *emacsclient* will instead try to start the
specified editor as a backup option.

For example: *--alternate-editor=/usr/bin/nano* would try to connect to an
*emacs daemon* and if that failed, it would start the *nano* editor. A new
*emacs daemon* would **not** be started. Leaving the *=* with no option means use
the default option, which is *emacs* in deamon mode.

At this point, I use the *VISUAL* variable for editors running in *X* or
*wayland* and *EDITOR* for editors running inside a terminal. This is not really
what they were originally intended for. However, that usage is archaic for most
users anyway. The original use assigned EDITOR for systems that did not have
interactive display screens or terminals. Basically, such systems consisted of a
teletype machine or a modem attached to a printer. Such a thing cannot update
the display, it just prints more stuff. The VISUAL variable was intended to
differentiate that new-fangled display monitors could update/refresh their
screens and that you could delete what you had previously typed/displayed.

So VISUAL meant an editor attached to a green-screen terminal display that could
overlay or refresh a screen and EDITOR meant a printer. In such olden days, you
would set EDITOR to something like the *ed* program and VISUAL to something like
*vi*. This is why *vi* is actually called *vi*, the *vi* being short for
*visual*-- because it took advantage of the fact that most people were now using
a display terminal instead of a printer and *ed* did not.

These archaic conventions are still used by some today-- often they are
significant for kernel or driver developers for debugging purposes. So you
should understand what these two variables mean to other UNIX era legacy
programs before you decide to mimic this setup, or you may run into issues when
using this setup with these programs.

Regardless of the intended original use, window environments like GNOME and KDE
are in the habit of looking for the VISUAL environment variable to tell them
what default editor to use. Command line terminal programs are in the habit of
using EDITOR to tell them what editor to use.

We are passing *-t* to run a terminal version when EDITOR is used by some other
program. This starts a new *emacs* client inside the terminal window.

When *VISUAL* is used, we create a new X window (actually, a *frame* in *emacs*
parlance) via the *-c* option. Without this, *emacs* would try and find an
existing X window and change the contents of that window/frame. I prefer to have
a new window (er... frame) for everything I explicitly open outside of *emacs*
and to leave my existing windows/frames alone.

Note that these commands and options are specific to recent versions of
*emacs*. Older versions of *emacs* and *emacsclient* take different
options. Very old versions of *emacs* don't have an *emacsclient*, or call it by
a different name.

## Systemd integration

You may take your setup one step further and have your emacs daemon managed by
*systemd*, so that it starts up automatically when the machine
starts. Instructions to do so are here:
<https://nilsdeppe.com/posts/emacs-c++-ide2>. I don't do this as it seems
overkill for most use cases. I am not much of a fan of *systemd* anyway.

## *emacs* daemon startup on Desktop load

Optionally, you could also start *emacs* in dameon mode when your X desktop
starts. Instructions for doing so are specific to the desktop or X environment
that you use, but usually involve something along the lines of running a
"Startup Programs" option under your desktop environments control panel or
settings dialog.

## Making emacs your tiling window manager

Another option worth consideration is just making *emacs* your window
manager/window environment. I like doing this for some virtual machines and as
one of my *sddm* login options.

See: <https://github.com/ch11ng/exwm>.

To see my notes on how I setup exwm: [EXWM.md](EXWM.md). They are still kinda raw.

Note that exwm has some issues since the maintainer disappeared. I find it worth
using, but many x-windows programs can hang it.

## Custom projectile project setup via dot dir-locals files

I sometimes set projectile variables to perform custom operations per project.
This is done via the dot dir-locals file at the root of each source project:
*.dir-locals.el*.

For example, I use the invoke package for all Python package build
targets.

When I lint code, I *invoke* this with:

```bash
invoke quality.lint
```

When I unittest code, I *invoke* this with:

```bash
invoke quality
```

Since I have setup custom actions to test, build, and compile code-- the
Projectile defaults do not really help as they don't do what I want them to
do. To fix this, at the root of your project (which is usually the top level
directory in a cloned git repository), create a file called
*.dir-locals.el*. Add to your file an elisp snippet similar to the following:


```elisp
((python-mode . ((projectile-project-test-cmd . "invoke quality")
                 (projectile-project-package-cmd . "invoke build.release")
                 (projectile-project-install-cmd . "invoke build.install-local")
                 (projectile-project-compilation-cmd . "invoke quality.lint"))))

```

Change the quoted commands to match your custom build, compile, install and test targets.
