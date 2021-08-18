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

# Repository usage

You can check this, or another similar repository out-- then configure it
further to meet your needs as you go. That is kinda how I ended up with this
repository, checking it out from someone else, adding my own settings and then
using it for years, before adding it back to *github*.

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
    When you first start *emacs* after cloning, you may get errors reported in the terminal window. This is because the settings you have cloned from *git* reference packages that have not been installed yet. Usually these are "require" statements that are failing since the package is missing. Most package includes are via the "use-package" directive, which is a bit smarter and tries to download the package if it is missing. Regardless, we can fix the missing includes in the next step.

4. List your installed packages:

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

5. It is likely that newer versions of packages will be installed than the stale
   ones listed in the *init.el* file checked out from the repo. You can refresh
   the repository listing by pressing 'r'. You can then download newer versions
   by marking them with *u*. Then press *x* to download and install the latest
   packages.

6. When all packages are installed, you can exit *emacs* and restart it. If you
   are running *emacs* in *daemon mode*, you need to restart the dameon:
   `killall emacs` and then restart. You should no longer see startup errors in
   the terminal. You can also re-evaluate the *init.el* source file via visiting
   the file in the buffer and running *eval-buffer*.

7. If you still are having errors with your setup, verify that you are running
   in an appropriate Python virtual environment. If you are on a redhat style
   distribution, you may need to enable a scl environment before starting
   *emacs*.

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
need to develop on Windows.

*emacs* is a second class citizen in this second class OS. You will need to
install some things to have a chance of getting an full-featured IDE
running. You can either mess with installing *emacs* as a part of a complete
Cygwin, Min32 or Windows UNIX toolkit, or you can try the Windows native version
of *emacs*. I prefer to run *emacs* in the native version. If that doesn't work,
then I install a virtual machine with a Linux flavor in its
entirety. Intermediary solutions with toolkit's typically cause more problems
than they solve, so I avoid them.

To get a *emacs* Windows native mostly working:

1. Get the latest zip file (installer exe) for *emacs*: <http://gnu.mirror.constant.com/emacs/windows/>
2. Run the installer.
3. You will need to download some utilities from <https://sourceforge.net/projects/ezwinports/>:
    * 3.1. <https://sourceforge.net/projects/ezwinports/files/latest/download>
    * 3.2. <https://sourceforge.net/projects/ezwinports/files/hunspell-1.3.2-3-w32-bin.zip/download> (or whatever is the latest)
4. Unzip these files into a parent directory.
5. Install pandoc for windows: <https://pandoc.org/installing.html>
6. Add the parent bin files directory to the environment variable
   PATH. i.e.
   * *C:\\Users\\USERNAME\\Downloads\\binutils\\binutils-2.35-w32-bin\\bin*
   * *C:\\Users\\USERNAME\\Downloads\\binutils\\hunspell-1.3.2-3-w32-bin\\bin*
   * *C:\\Users\\USERNAME\\AppData\\Local\\Pandoc\\*
7. Edit *emacs.d/custom/setup-windows.el* to setup windows specific customizations.
8. Edit *emacs.d/init.el* and remove the comments before *(require setup-windows.el)*
9. Now start *emacs* and load your packages.
10. Check your changes in to your windows specific branch.


## Saving Changes to your configuration

*Don't forget to commit and push your changes back to your repository.*

Note that *emacs* can interactively change the contents of your
*~/emacs.d/init.el* file as it saves updates you have requested. *emacs* does
this when you use drop-down menu options to change settings or when you install
or upgrade packages via *package-list-packages*.

You should make sure you are done making such changes before you attempt to
commit your changes with git. To commit changes, you can either use *git* on the
command line, or you can use *magit* inside *emacs*. *magit* is a powerful
*emacs* integration layer that is worth learning, and basic usage is fairy
intuitive.

# How to build emacs from source

This main branch tracks the bleeding-edge of *emacs* and requires an un-released
version of *emacs* built from source.

To build *emacs* from source, please see: [BUILD.md](BUILD.md).

# Repository Layout

This *emacs.d* directory divides emacs setup into several files. At the top
level, the *init.el* file contains only the most generic of *emacs* settings. In
our setup, it's main purpose is to require other settings files, which live
under the *custom* subdirectory. This lets us break out portions of setup code
into bite-sized and purpose specific pieces. This is preferable to having
everything inside one large file. The main downfall of this approach is that
sometimes packages interact with other packages-- such as *lsp mode* and many
minor-mode packages. In these cases, it isn't always clear where to put setup
content. I attempt to put it where it best fits.

The following list shows the settings files and a brief description of what they
do:

* **init.el:** Main configuration entry point. Sets the package repository (melpa). Specifies required packages and custom setup files that must be loaded.
* **custom/setup-secrets.el.gpg:** This isn't checked in, you should create it from <./skel/setup-secrets.el>. This is a *gpg* encrypted file with elisp code that is meant to house your passwords and secrets. Don't check it in.
* **custom/setup-general.el:** Contains generic display setup. Examples of such would be: match parenthesis, don't show the tool bar, display the time, set the time zone, etc.
* **custom/setup-helm.el:** Contains setup instructions specific to *helm*. Disabled by default. Helm is an alternate incremental completion framework that replaces the default i-search completion. See <https://github.com/emacs-helm/helm>, and the helm section below.
* **custom/setup-ivy-counsel.el:** Contains setup instructions specific to *ivy and counsel*. Ivy is an alternate incremental completion framework that replaces the default i-search completion. See <https://github.com/abo-abo/swiper>, and the ivy section below.
* **custom/setup-editing.el:** Contains generic file editing setup that is not specific to a major or minor mode, or to any other more specific *emacs* subsystem.
* **custom/setup-programming.el:** Contains setup specific to generic programming language support.
* **custom/setup-spelling.el:** Setup specific to spell checking.
* **custom/setup-git.el:** Contains setup information specific to using *git*, *github*, Azure DevOps and similar.
* **custom/setup-projectile.el:** Contains setup specific to the projectile project management system.
* **custom/setup-shell.el:** Setup specific to shell scripting.
* **custom/setup-markdown.el:** Contains setup specific to markdown mode.
* **custom/setup-python.el:** Contains setup specific to Python programming.
* **custom/setup-javascript.el:** Contains setup specific to Javascript programming.
* **custom/setup-c.el:** Contains setup specific to C/C++ programming.
* **custom/setup-orgmode.el:** Contains setup specific to organizational mode, including syncing meetings/agenda items with a remote server.
* **custom/setup-theme.el:** Contains setup specific to the default theme selection.
* **custom/setup-windows.el:** Setup specific to running *emacs* on windows. Disabled by default.

If you don't need a portion of this setup, simply remove the *(require
 'setup-{item).el)* require statement from the *init.el* file. Further, add your
 own stuff as well. For example, to support another language such as Go you
 could add file: *setup-go.el* in *./custom* and require it in *init.el*.

# Installed packages and a brief summary of what they do

Please see: [INSTALLED.md](INSTALLED.md).

# My notes on using emacs as a Python 'IDE'

Please see: [PYTHONENV.md](PYTHONENV.md).

# General emacs Environment Setup on Linux

Please see: [GENERALENV.md](GENERALENV.md).

# Setting up the Kenesis Advantage II keyboard for emacs

Please see: [KENESIS.md](KENESIS.md).
