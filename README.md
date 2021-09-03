# My ~/.emacs.d setup

This is my configuration for GNU *emacs*, along with my extensive setup
notes. This setup is tailored for Python, C++ and some Javascript
development. Currently, this branch contains settings intended for GNU *emacs*
from the head of the master branch of the *GNU emacs* source repository at
*git.savannah.gnu.org/emacs.git*.

These features are not currently released in an official build and are slated
for *emacs 28*. I have switched from running an officially supported build due
to native compilation support, which is much faster overall and makes extensive
*IDE* features quick enough to be usable.

To use this setup fully, you will need a bleeding-edge version of *emacs*--
tracking the head of the master branch. See: [BUILD.md](BUILD.md)].

# Tutorials & Resources

For resources on learning and configuring *emacs*, please see:
[TUTORIALS.md](TUTORIALS.md).

# Repository Layout

This *emacs.d* directory divides emacs setup into several files. At the top
level, the *init.el* file contains only the most generic of *emacs* settings. In
this setup, it's main purpose is to require other settings files, which live
under the *custom* subdirectory. This lets us break out portions of setup code
into bite-sized and purpose specific pieces. This is preferable to having
everything inside one large file. The main downfall of this approach is that
sometimes packages interact with other packages-- such as *lsp mode* and many
minor-mode packages. In these cases, it isn't always clear where to put setup
content. I attempt to put it where it best fits, but removing one package may
require editing of more than one setup file.

The following list shows the settings files and a brief description of what they
configure:

* **init.el:** Main configuration entry point. Sets the package repository (melpa). Specifies required packages and custom setup files that must be loaded.
* **custom/setup-secrets.el.gpg:** This isn't checked in, you should create it from [./skel/setup-secrets.el](./skel/setup-secrets.el). This is a *gpg* encrypted file with elisp code that is meant to house your passwords and secrets. Don't check it in.
* **custom/setup-general.el:** Contains generic display setup. Examples of such would be: match parenthesis, don't show the tool bar, display the time, set the time zone, etc.
* **custom/setup-helm.el:** Contains setup instructions specific to *helm*. Disabled by default. Helm is an alternate incremental completion framework that replaces the default i-search completion. See <https://github.com/emacs-helm/helm>.
* **custom/setup-ivy-counsel.el:** Contains setup instructions specific to *ivy and counsel*. Ivy is an alternate incremental completion framework that replaces the default i-search completion. See <https://github.com/abo-abo/swiper>.
* **custom/setup-editing.el:** Contains generic file editing setup that is not specific to a major or minor mode, or to any other more specific *emacs* subsystem.
* **custom/setup-programming.el:** Contains setup specific to generic programming language support, mainly lsp configuration.
* **custom/setup-spelling.el:** Setup specific to spell checking.
* **custom/setup-git.el:** Contains setup information specific to using *git*, *github*, Azure DevOps and similar.
* **custom/setup-projectile.el:** Contains setup specific to the projectile project management system.
* **custom/setup-shell.el:** Setup specific to writing shell scripts.
* **custom/setup-markdown.el:** Contains setup specific to editing markdown.
* **custom/setup-python.el:** Contains setup specific to Python programming.
* **custom/setup-javascript.el:** Contains setup specific to Javascript programming.
* **custom/setup-c.el:** Contains setup specific to C/C++ programming.
* **custom/setup-orgmode.el:** Contains setup specific to using organizational mode, including syncing meetings/agenda items with a remote server.
* **custom/setup-theme.el:** Contains setup specific to the default theme selection.
* **custom/setup-windows.el:** Contains setup specific to running *emacs* on the Windows OS. Disabled by default.
* **custom/setup-exwm.el:** Contains setup specific to making *emacs* an X-windows window manager. This would replace KDE or GNOME desktop environments with *emacs* itself.

If you don't need a portion of this setup, simply remove the *(require
 'setup-{item).el)* require statement from the *init.el* file. Further, add your
 own stuff as well. For example, to support programming in another language such
 as Go you could add file: *setup-go.el* in *./custom* and require it in
 *init.el*.

**Note:** I don't use org mode to manage *emacs* configuration via
entanglement. This is a very popular way to manage your *emacs* setup and many
do it now. To me code should be self-documenting and not include lots of
comments. Mixing them via org mode seems like an excellent approach for
learning/teaching, but I don't really like the approach for everyday use.

It is personal preference. Plus, I already am used to using markdown/info-tek
and other documentation markup languages and I don't yet like using org-mode
for those purposes.

# Repository usage

You can check this, or another similar repository out-- then configure it
further to meet your needs as you go. I ended up with this repository by
checking it out from someone's C++ tutorial setup, adding my own settings and
then using it for years, before adding it back into *github* to share with
others in my organization.

To copy this *emacs* setup, or any similar one you see checked in to a github
source repository:

1. Fork the repository in question into your own github account. To fork a
   repository, see:
   <https://help.github.com/en/github/getting-started-with-github/fork-a-repo>. Optionally,
   you may want to create a template from the forked repository that every
   emacs' user in your organization can use to share common settings, see:
   <https://help.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template>.

2. Next, you should clone your new repository to every machine where you use
   *emacs*. When you clone it, clone it to your *emacs.d* settings directory. On
   Linux, this is in your home directory at: *~/.emacs.d*:

    ```bash
    # goto home directory
    cd ~/
    # move your old emacs settings, if any-- out of the way
    mv ~/.emacs.d ~/.emacs.d.old
    # clone your new settings directory
    git clone git@github.com:YOURGITHUBUSERHERE/emacssetup.git ~/.emacs.d/
    ```
    This allows you to have one setup for all machines that run a compatible version of *emacs*, and to keep that setup synchronized.

3. Start *emacs*.

    ```bash
    $ emacs
    ```

    When you first start *emacs* after cloning, you may get errors reported in
    the terminal window. This is because the settings you have cloned from *git*
    reference packages that have not been installed yet. Usually these are
    "require" statements that are failing since the package is missing. Most
    package includes are now via the "use-package" directive, which is a bit
    smarter and tries to download the package if it is missing. Regardless, we
    can fix the missing includes in the next step.

4. List install and update packages:

    * **M-x list-packages:** This shows the packages available. Press 'r' to reload available packages from the configured repositories (melpa).
    * **M-x package-install-selected-packages:** installs all packages listed in our *.emacs.d/init.el* file, in section *package-selected-packages*.

    Note that it may appear that *emacs* has hung when you run *M-x
    package-install-selected-packages*. You may see a message in the mini-buffer
    that states: *"Contacting Melpa..."*. You are especially likely to see this
    if you have a slow connection. *emacs* probably isn't hung, but just
    busy. If you look in directory *~/.emacs.d/elpha/*, you will see that
    packages are appearing as they are downloaded. If you restart *emacs* before
    it finishes downloading a large package-- then it will loose track of the
    current package and you will just end up having to download it again later.

5. It is likely that newer versions of packages can be installed than what are
    referenced in the stale *init.el* file checked out from the repo. You can
    refresh the repository listing by pressing 'r'. You can then download newer
    versions by marking them by pressing *u*. Then press *x* to download and
    install the latest packages.

6. When all packages are installed or updated, it is probably best to exit
   *emacs* and restart it. If you are running *emacs* in *daemon mode*, you need
   to restart the dameon: `killall emacs` from a shell and then restart. You can
   also re-evaluate the *~/emacs.d/init.el* source file via visiting the file in
   the buffer and running *eval-buffer*. Depending on what changed, it may not
   reload all changes reliably. If you have an issue after evaluating the
   buffer, restart *emacs* before continuing to troubleshoot.

7. After restarting, you should no longer see startup errors in the *Messsages*
   buffer or printed to the terminal screen. If you still are having errors with
   your setup, verify that you are running in an appropriate Python virtual
   environment, if applicable. If you are on a RHEL style distribution, you may
   need to enable a scl environment before starting *emacs*, if it was complied
   against said environment.

## Sharing your settings across machines

Since this is a *git* repository, it is easy to use across multiple machines,
you just clone it to every machine where you use *emacs*. Occasionally, you may
have compatibility issues with the version of *emacs* installed on a machine.
If you cannot modify your setup such that it works everywhere, then create a
branch for each setup you need.

A good example of this would be creating a branch for each major version of
*emacs*: an emacs 27 branch, a 26 branch, etc. Then you just clone the repo and
checkout the branch matching your version.

Another use is to create a branch for each operating system you use.

Currently, this repository has branches for *GNU emacs-26*, *GNU emacs-27*, and
a *windows* branch that is a fork of the *GNU emacs-27* branch. The *master*
branch tracks the master branch of *GNU emacs* and assumes you have built from
source with native compilation enabled.

## Windows Specific Stuff

This repository has a windows branch that gets updated from time-to-time when I
need to develop on Windows. My notes for setting up *emacs* on *Windows* are here:
[WINDOWS.md](WINDOWS.md).

## Saving Changes to your configuration

*Don't forget to commit and push your changes back to your repository.*

Note that *emacs* can interactively change the contents of your
*~/emacs.d/init.el* file as it saves the package and configuration updates you
have requested. *emacs* does this when you use drop-down menu options to change
settings or when you install or upgrade packages via *package-list-packages*.

You should make sure you are done making such changes before you attempt to
commit your changes with git. To commit changes, you can either use *git* on the
command line, or you can use *magit* inside *emacs*. *magit* is a powerful
*emacs* integration layer that is worth learning, and basic usage is fairy
intuitive.

# How to build emacs from source

This main branch tracks the bleeding-edge of *emacs* and requires an un-released
version of *emacs* that is built from source.

To build *emacs* from source, please see: [BUILD.md](BUILD.md).

# Installed packages and a brief summary of what they do

Please see: [INSTALLED.md](INSTALLED.md).

# Notes on using emacs as a Python 'IDE'

Please see: [PYTHONENV.md](PYTHONENV.md).

# General emacs environment setup on Linux

How to get *emacs* and GNU Linux to cooperate most effectively:
[GENERALENV.md](GENERALENV.md).

# Using emacs as a window manager with exwm

Please see: [EXWM.md](EXWM.md).

# Setting up the programmable Kenesis Advantage II keyboard for emacs

Please see: [KENESIS.md](KENESIS.md).

# Hacks that I have had to do to get some packages working

Please see: [HACKS.md](HACKS.md).

# Things I don't use *emacs* for and bugs I have not solved

Please see: [UNUSED.md](UNUSED.md).
