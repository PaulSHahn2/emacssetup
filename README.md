# My ~/.emacs.d setup

This is my configuration for GNU *emacs*, along with related usage notes. This
setup is tailored for Python, C++ and some Javascript development. Currently,
this branch contains settings intended for GNU *emacs* from the head of the
master branch of the *GNU emacs* source repository at
*git.savannah.gnu.org/emacs.git*.

These features are not currently released in an official build and are slated
for *emacs 28*. I have switched from running an officially supported build due
to native compilation support, which is much faster overall and makes *lsp-mode*
quick enough to be usable.

To use this setup fully, you will need a bleeding-edge version of *emacs*
tracking the head of the master branch. See instructions below: *How to build
emacs from source*.

# Tutorials & Resources

If you are new to *emacs* you may want to read some tutorials before copying
anyones setup, or just installing a pre-configured distribution of *emacs* like
*doom* or *spacemacs*.

A good place to start is reading the official GNU manual for *emacs*. You can do
this on your local machine using the *info* command, or you can read the online
manual: <https://www.gnu.org/software/emacs/manual/>.

Much of this setup has been taken from the sources below over the years and modified
for my specific use.

## emacs from scratch

I would recommend that you learn *emacs* by setting it up yourself. The System
Crafters' video series and repository serves as a good starting point and
provides a much more detailed configuration when finished:

* <https://www.youtube.com/watch?v=74zOY-vgkyw&list=PLEoMzSkcN8oPH1au7H6B7bBJ4ZO7BXjSZ>

There is a time investment required to watch the videos and starting at the
beginning is required, or you will be lost. They manage configuration changes
and documentation changes together, and "de-tangle" and rebuild their *emacs*
setup on-the-fly from their documentation. This approach is the inverse of the
typical Doxygen/JavaDoc/PyDoc-- instead of creating documentation from code
comments, code included in-line with the comments is then stitched together from
the documents to create your configuration. This allows the newer user to see
the comments explaining what the *elisp* setup code is actually doing, since
most new *emacs* users are not proficient lisp programmers.

## Pre-configured emacs distributions

Your other option is to borrow/take someone else's setup, like copying this
repository. This gets you going temporarily, but may come at the expense of you
not knowing how to setup and customize your environment later on.

There are modified distributions of *GNU emacs* that are purpose specific and
configured "out-of-the-box". They won't work with this setup since they provide
their own pre-rolled packages and settings. You may wish to consider using one
of them.

**Spacemacs** is geared to *emacs* beginners with *vi/vim* experience:

* <https://www.spacemacs.org/>

**Doom-emacs** is geared to more experienced power users who want a leaner
experience than spacemacs:

* <https://github.com/hlissner/doom-emacs>

**Prelude** is a distribution of *emacs* geared towards simplicity and
reliability. It is more conservative and closer to *emacs*, but with packages
setup to work in most languages:

* <https://prelude.emacsredux.com/en/latest>

## General resources:

Regardless of the approach you take, some good resources you may want to
bookmark follow. I try to keep these up-to-date, but the world moves fast and
some of them maybe a bit stale.

* <https://www.emacswiki.org/>
* <http://ergoemacs.org/>
* <https://www.reddit.com/r/emacs/>
* <https://masteringemacs.org>

## LSP Setup

* <https://emacs-lsp.github.io/lsp-mode/>
* <https://www.youtube.com/watch?v=jPXIP46BnNA&list=PLEoMzSkcN8oNvsrtk_iZSb94krGRofFjN&index=3>

## C++ setup resources:

* <http://tuhdo.github.io/c-ide.html>
* <https://nilsdeppe.com/posts/emacs-c++-ide2>
* <https://www.sandeepnambiar.com/setting-up-emacs-for-c++/>
* <https://trivialfis.github.io/emacs/2017/08/02/C-C++-Development-Environment-on-Emacs.html>


## Python setup resources:

Configuring *lsp-mode* to work with *python-lsp-server*:

* <https://github.com/python-lsp/python-lsp-server>

Using elpy instead of lsp:

* <https://elpy.readthedocs.io/>


## Javascript setup resources:

* <https://patrickskiba.com/emacs/2019/09/07/emacs-for-react-dev.html>
* <http://wikemacs.org/wiki/JavaScript>


# How to build emacs from source

Sometimes, the distributions version of *GNU emacs* is not up to par. Currently,
this is the case for me as *GNU emacs* from git source contains features that
are very compelling, like native compilation of emacs lisp files via
*libgccjit*. These features are missing from *GNU emacs 27*.


Below are my brief notes for building your own *GNU emacs*. You will need the source
code to the version of *emacs* that you wish to build.


## Building GNU emacs 27+ On Debian/Ubuntu (and similar):

```bash
# add sources repos in /etc/apt/sources.list by uncommenting srcs repositories matching the binary equivalents.
sudo apt-get update
# this isnt perfect as it doesnt track the most recent emacs but it gets you close
sudo apt-get build-dep emacs
# some other things that you want, versions may be out of date
sudo apt-get install libgtk-3-dev libwebkit2gtk-4.0-dev libjansson-dev libjansson4 libgccjit-10-dev
# checkout emacs
git clone git://git.savannah.gnu.org/emacs.git
cd emacs
./autgen.sh
# change the prefix to be the install location you wish for emacs to be installed to. Your local home directory if you want.
./configure --with-modules --with-cairo --with-xwidgets --with-x-toolkit=gtk3 --with-mailutils --with-imagemagick --with-native-compilation --prefix=/usr/local
# go to lunch if you have a slow machine, this takes awhile as emacs compiles all emacs lisp to machine code
make -j
sudo make install prefix=/usr/local
```

## Building GNU emacs 27+ On RHEL (and similar):

```bash
 sudo yum -y install jansson jansson-devel devtoolset-10-all devtoolset-10-toolchain devtoolset-10-perftools devtoolset-10-libgccjit devtoolset-10-libgccjit-devel devtoolset-10-build

scl enable devtoolset-10 bash

git clone git://git.savannah.gnu.org/emacs.git

cd emacs

./autogen.sh

./configure --with-modules --with-cairo --with-xwidgets --with-x-toolkit=gtk3 --with-mailutils --with-imagemagick --prefix=/usr/local --with-native-compilation

# go to lunch if you have a slow machine, this compiles all emacs lisp files to native machine code
make -j

# install
sudo make install prefix=/usr/local
```

Note that on RHEL you will need to enable devtoolset-10 via *scl* each time you start your sessions, before you can run *emacs*. 
I typically also start my Python virtual environment before starting the *emacs* daemon.

# Repository usage

You can check this, or another similar repository out-- then configure it
further to meet your needs as you go. That is kinda how I ended up with this
repository, checking it out from someone else, adding my own settings and then
using it for years, before adding it back to github.

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
    When you first start *emacs* after cloning, you may get errors reported in the terminal window. This is because the settings you have cloned from *git* reference packages that have not been installed yet. Usually these are "require" statements. All newer setup uses the "use-package" directive which is a bit smarter and tries to download the package if it is missing. Regardless, we will fix this in the next step by installing the missing packages.

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
   version.

6. When all packages are installed, you can exit *emacs* and restart it. If you
   are running *emacs* in *daemon mode*, you need to restart the dameon:
   `killall emacs` and then restart. You should no longer see startup errors in
   the terminal. You can also re-evaluate the *init.el* source file via
   *eval-buffer*.

## Sharing your settings across machines

Since this is a *git* repository, it is easy to use across multiple machines,
you just clone it to every machine where you use *emacs*. Occasionally, you may
have issues with one machines version of *emacs*.  If you cannot modify your
setup such that it works everywhere, then create a branch for each setup you
need.

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
install some things to have a chance of getting an IDE running. You can either
mess with installing *emacs* as a part of a complete Cygwin, Min32 or Windows
UNIX toolkit, or you can try the Windows native version of *emacs*. I prefer to
run *emacs* in the native version. If that doesn't work, then I install a
virtual machine with a Linux flavor in its entirety. Intermediary solutions with
toolkit's typically cause more problems than they solve, so I avoid them.

To install in the native environment:

1. Get the latest zip file (installer exe): <http://gnu.mirror.constant.com/emacs/windows/>
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
10. Check your changes in to a windows specific branch.


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

# Repository Layout

This *emacs.d* directory divides emacs setup into several files. At the top
level, the *init.el* file contains only the most generic of *emacs* settings. In
our setup, it's main purpose is to require other settings files, which live
under the *custom* subdirectory. This lets us break out portions of setup code
into bite-sized and purpose specific pieces, instead of having everything inside
one large file.

The following list shows the settings files and a brief description of what they
do:

* **init.el:** Main configuration entry point. Sets the package repository (melpa). Specifies required packages and custom setup files that must be loaded.
* **custom/setup-general.el:** Contains generic display setup. Examples of such would be: match parenthesis, don't show the tool bar, display the time, set the time zone, etc.
* **custom/setup-editing.el:** Contains generic file editing setup that is not specific to a mode or *emacs* subsystem.
* **custom/setup-git.el:** Contains setup information specific to *git* and *github*.
* **custom/setup-helm.el:** Contains setup instructions specific to *helm*. Disabled by default. Helm is an alternate incremental completion framework that replaces the default tab completion. See <https://github.com/emacs-helm/helm>, and the helm section below.
* **custom/setup-ivy-counsel.el:** Contains setup instructions specific to *ivy and counsel*. Ivy is an alternate incremental completion framework that replaces the default tab completion. See <https://github.com/abo-abo/swiper>, and the ivy section below.
* **custom/setup-c.el:** Contains setup specific to C/C++ projects and files.
* **custom/setup-python.el:** Contains setup specific to Python projects and files.
* **custom/setup-javascript.el:** Contains setup specific to Javascript projects and files.
* **custom/setup-theme.el:** Contains setup specific to the default theme selection.

If you don't need a portion of this setup, simply remove the *(require
 'setup-{item).el)* require statement from the *init.el* file. Add your own
 stuff as well. For example, to support another language such as Go you could add file:
 *setup-go.el* in *./custom* and require it in *init.el*.

# Installed packages and a brief summary of what they do

There are many options and packages available in modern *emacs*. It is
dizzying. Many compete with each other to do similar tasks, but in different
ways. These packages will often conflict with each other. It is best to install
and use **one** new thing at a time. Learn what it can do for you and make sure it
is not causing any issues before installing the next package. 

Getting packages to play together is a trial and error process. To get them to
use each other seamlessly you frequently have to edit configuration files and
setup variables so that one package knows to use another one.

Sometimes, packages conflict with each other and try to take the same
key-bindings and run from the same hooks. If you delve deep into your
configuration, you can often make them get along. 

While learning, it is best to keep some simplicity and use one package for a
particular purpose.

Below I describe the packages currently used in this setup and where you can go
to get more information about them.

## company & company-box

**company** is a text auto-completion framework for *emacs* that runs in a pop
overlay. *company* provides a pluggable search framework for auto-complete
results/suggestions. So the company front-end uses various code completion
back-ends. Each back-end provides suggestions. Company pops-up a window with the
resulting lists in an drop-down style overlay over the top of the current
buffer. The user can navigate the options presented and select the desired
item. Then the overlay then goes away. See: <https://company-mode.github.io/>.
Company only works with simple overlays over a buffer, more complex completion
frameworks that require their own buffer are also included as options and
described below in *Display completion engines*.

**company-box** Extends company to support the display of icons in-line with
text results. This requires certain compile-time options to be set and certain
libraries must be available at runtime. The icons are meant to provide
additional context to help the user identify the items listed. The colors of the
icons are meant to identify the backend that provided the suggestion. The icons
themselves are meant to identify type of completion item, i.e. a variable or a
function call. See: <https://github.com/sebastiencs/company-box>.

## async

**async** supports running code asyncronously, which lets elisp cooperatively
switch between running processes whenever a process blocks on I/O. This is
similar to Node.js or Python asyncio. It is used by other packages to help
*emacs* perform better. See: <https://github.com/jwiegley/emacs-async>.

## window-numbering

Allows us to simply switch between windows in a frame with *M-#*, where number
is the number of the window from top to bottom, left to right. See:
<http://nschum.de/src/emacs/window-numbering-mode/>. This is much faster than
using *C-x o* repeatedly.

## Display completion engines

Much of the time, completion lists are too complicated to use a pop-up, like
company.

Emacs comes with a basic completion framework built-in that displays items
either in a special buffer called a *mini-buffer*.  This mini-buffer provides
basic tab-style completion.

Other options with more advanced completion exist as well, like helm, ido and
ivy/counsel.  This setup lets you can choose from the default *emacs*
mini-buffer tab completion, from *helm* or from *ivy-counsel*. You can do this
by editing your *init.el* file The default selection is currently *ivy-counsel*.

To change the default *ivy/counsel* to *helm*, edit your *init.el* file:

```lisp
;; helm completion control
(require 'setup-helm)
;; ivy counsel completion control
;;(require 'setup-ivy-counsel)
```

To disable *ivy/counsel* and use the built-in *emacs* tab-completion:

```lisp
;; helm completion control
;; (require 'setup-helm)
;; ivy counsel completion control
;;(require 'setup-ivy-counsel)
```

A brief description of helm and ivy follow.

### helm & helm-swoop

**helm** is an advanced completion display engine for *emacs* that allows you to
narrow results from provided lists in a frame or buffer. It extends and replaces
the default tab completion that comes out of the box with *emacs*. 
<https://emacs-helm.github.io/helm/>

**helm-swoop** uses helm to display matching content in another buffer and replaces the default *emacs i-search*. See
<https://github.com/emacsorphanage/helm-swoop> and
<https://www.emacswiki.org/emacs/HelmSwoop>. This is a helper package used by
other packages and specific configurations when it would be more appropriate to
display the results in a separate buffer (window frame).

### ivy & counsel

**ivy** is a more recent completion framework for *emacs*. It is considered faster then *helm*, but was originally more limited. Its features are improved and its speed advantage is probably over-stated. It integratesn nicely with *all-the-icons*.

**counsel** is a collection of ivy-enhanced replacement commands for *emacs*. These commands are bound over the default *emacs* commands to provide ivy completion functionality, instead of the *emacs* default tab-completion.

**swiper** uses counsel to display matching content in another buffer and replaces the default *emacs i-search*.
*ivy/counsel/swiper* are currently the default completion frameworks.

## projectile, helm-projectile & counsel-projectile

**projectile** is an *emacs* package that adds project management support. This
is similar to how monolithic IDE's provide their own (often IDE specific)
project file format (or use something like *Maven*).  Projectile includes
support for automatic refactoring of code and movement between files within
projects.  It is programming language and tool agnostic and attempts to
recognize projects of different types created by different tools. Frequently
support for specific project types is added via the use of tool specific plugins
and extensions.

See: <https://docs.projectile.mx/en/latest/>

**helm-projectile** is an *emacs* package that extends projectile to use helm
completion. See <https://github.com/bbatsov/helm-projectile>.

**counsel-projectile** is an *emacs* package that extends projectile to use
ivy/counsel completion.

## whitespace ws-butler or whitespace-cleanup-mode

I use two different packages that can get rid of bad white-space.

1. **ws-bulter:** The enabled default. This is a gentler program that only
   cleans up whitespace in the area you have modified. Everyone else's strange
   whitespacing is left alone. This is the default enabled in most editing and
   programming modes. See: <https://github.com/lewang/ws-butler>.

2. **whitespace-cleanup-mode:** This nukes all erroneous whitespace in the file
   everytime you save to disk. It is not on by default, but just installed. See:
   <https://github.com/purcell/whitespace-cleanup-mode>.

### Which whitespace option should you use?

If you are working on legacy code with others, you should probably use
*ws-butler*. Using *whitespace-cleanup-mode* will result in huge commit sizes
that have nothing to do with your change. This occurs since you will have
reformatted the entire file every-time you save. If you are on greenfield
development it should not matter as much-- *ws-bulter* will keep you safe to
begin with. If you are refactoring or cleaning up code, then
*whitespace-cleanup-mode* may be a better choice since it lets you aggressively
fix bad whitespace.

You can manually start *whitespace-cleanup-mode* on any buffer via *M-x
whitespace-cleanup-mode*. You can set it up to be always on instead of
*ws-bulter* by editing *~/emacs.d/custom/setup-editing.el* and removing the
lines commenting out *global-whitespace-cleanup-mode*. You should also comment
out *ws-butler* at the same time (you really only want one running at a time).

## volatile-highlights

**volatile-highlights** briefly shows us text that has been altered or pasted
in. The text will appear highlighted until the next keystroke. This provides a
tiny bit more visual context to what we have done. See:
<https://www.emacswiki.org/emacs/VolatileHighlights>.

## undo-tree

**undo-tree** makes *emacs* undo features behave a bit more like *vim*. Instead
of a linear undo, we can see a tree of changes and move between those
changes. See <http://www.dr-qubit.org/emacs.php> and
<https://www.emacswiki.org/emacs/UndoTree>. This is handy, but complicated to
learn if you are used to the default behavior. I frequently get frustrated with
remembering the new approach and may disable this at some point.

## yasnippet

**yasnippet** is an abbreviation template system for *emacs*. We create a setup
file with abbreviations and their expanded equivalents. When we type the
abbreviation, we can optionally expand it to the full equivalent text. See:
<https://www.emacswiki.org/emacs/Yasnippet> &
<http://github.com/joaotavora/yasnippet>.

## anzu

**anzu** is a minor-mode that displays the current match and the number of total
matches in the mode-line whenever a search is occurring. See:
<https://github.com/emacsorphanage/anzu>.

## iedit

**iedit** Let's you edit multiple matching targets simultaneously. See:
<https://github.com/victorhge/iedit>.

## markdown & markdown-preview modes

Provides the ability to edit markdown files and see the output of files edited
in a browser. *markdown-preview-mode* tracks changes on-the-fly by starting up a
server and connecting your browser to the servers endpoint. Each time you save a
change, the endpoint is regenerated. *markdown-mode* provides syntax
highlighting. See: <https://www.emacswiki.org/emacs/MarkdownMode>.

## flyspell & flyspell-correct

Provides spell-checking as you go. See: <https://github.com/d12frosted/flyspell-correct>.

## flycheck

Checks syntax for various programming languages as you go. This is used to
display linting results and similar. It also has companion backend language and
tool specific packages that provide it with information.

Some of these work as a backup to *lsp-mode*. For example, *YAML* uses
*flycheck-yamllint* to provide data to *flycheck* about YAML files.

However, this setup will use *lsp-ui* as a backend to *flycheck* to display
results provided from *lsp* servers for the Python and C++ languages.

See: <https://www.flycheck.org/en/latest/>

## lsp-mode, lsp-ui, ccls

**lsp-mode** enables the language server protocol support for *emacs*. This
allows code completion and syntax highlighting for multiple programming
languages. *lsp* takes a client server approach to code management. Instead of
plugins running as a part of the editor, the plugin calls out to a another
server process that implements support for a particular programming
language. This allows developers of language features to focus on delivering
engineering features and not focus on integration with one particular IDE or
editor. This approach means that you will have to have a server running for each
programming language you want supported. *emacs* *lsp-mode* starts these servers
for you as needed. The installation is more complicated because in addition to
*emacs* you will have to configure and install the server separately.

I have found that unlike other C tagging solutions, the *lsp-mode* server scales
well and is relatively fast. It lets us integrate with third-party services, and
interfaces to investigate our code.  See:
<https://github.com/emacs-lsp/lsp-mode> and <https://emacs-lsp.github.io/>.

Languages available are listed here: <https://emacs-lsp.github.io/lsp-mode/page/languages/>.

You can edit *custom/setup-editing.el* to disable *lsp-mode* if you do not want this feature.

**lsp-ui** Contains ui features to display results from the lsp server. See:
<https://github.com/emacs-lsp/lsp-ui>

**emacs-ccls** is an emacs mode that runs the ccls server (you must install ccls
server). This server provides lsp data for C/C++ & Objective C. See:
<https://github.com/MaskRay/emacs-ccls>.

The current setup enables ccls for C and C++. You can edit *custom/setup-c.el*
to change this.

In order to use the features of ccls and lsp-mode, you will need to have *ccls*
installed.  For detailed instructions on how to install and setup the *ccls*
server are here: <https://github.com/MaskRay/ccls/wiki>.

Yet, quick instructions follow:

Debian based:

```bash
sudo apt-get install clang ccls
```

For RHEL, you must follow the instructions in the above wiki to build from
source or add a snap. You will have to install *snap* from epel packages to use
*snaps*:

```bash
sudo yum install snapd
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install ccls --classic
```

**Note:** Enabling snaps and installing a classic snap has its own security
implications. Know that before you blindly type the above into a terminal.

**python-lsp-server** If you want to use lsp-mode with Python, you will need a
python language back-end, such as the *python-lsp-server*. Since
*python-lsp-server* is a python package, you can install it in your python
environment with pip:

```bash
pip install python-lsp-server[all]
```

The current setup enables *python-lsp-server*. You can edit
*custom/setup-python.el* and *custom/setup-editing.el* to change or disable
it.

Note that the default install of *python-lsp-server* sets it up to use *flake8* by default.

Further note that the *python-language-server* by Palantir is the deprecated
older version of *python-lsp-server*, so **don't** install it, this version is
more recent.

## Native code compilation

This setup uses native compilation. in *setup-general.el* you will see:

```elisp
(setq comp-deferred-compilation t)
```

This option means that when you start *emacs* after upgrading packages from
*melpa/elpha*-- that *emacs* will compile all *emacs lisp* files to native
machine code. This will cause *emacs* to pause and will use large amounts of CPU
while compiling. Once done, things are **much** faster. Comment the line out if
you don't want this.

## magit

A full *git* layer for integration of git with emacs. This is very handy and
very well done. See:
<https://magit.vc/manual/magit/Getting-Started.html#Getting-Started>.

## git-gutter

Keeps track of changes to our git version controlled files in a small "gutter"
window on the left of the buffer. See:
<https://github.com/emacsorphanage/git-gutter>.

## git-timemachine

Lets us navigate and interactively view the versions of a git controlled
file. See: <https://github.com/emacsmirror/git-timemachine>.

## Javascript and json support via tide and JSX
*emacs 27* provides native support for react and typescript via *JSX*.

The *tide* package further extends this support. See <http://github.com/ananthakumaran/tide>.

# Notes on using emacs as a Python 'IDE': eply or lsp-mode

There are two Python IDE environments I have used, and which this configuration
can support: *lsp-mode* with *python-lsp-server* or *elpy*.

Both provide advanced Python specific IDE abilities and greatly enhance the
Python programming experience inside *emacs*.

Both have some of the same features and this overlap means they are not fully
compatible. You will have to pick between them.

In general, *elpy* is a bit leaner. *lsp-mode* is slower and provides a more
consistent interface between the different programming languages which
*lsp-mode* supports.

*lsp-mode* is a compelling choice if you use the lsp-server to enforce
consistent style and code requirements across a shop/team. You simply pick a
server and configure it with the standard requirements and everyone can use
their own preferred editor/IDE pointed at the lsp server. Then everyone is
writing code to the same standards.

The default setup for Python uses *python-lsp-server*.

## Using *python-lsp-server*

*lsp-mode* should start or connect to an existing *python-lsp-server* whenever
you open any python file.

If lsp-mode is running poorly, you can triage the situation with *lsp-doctor*.

A good guide for using *lsp-doctor* and increasing *lsp-mode* performance is
found here: <https://emacs-lsp.github.io/lsp-mode/page/performance/>.

A good guide for configuring and setting up *python-lsp-server* is here:
<https://emacs-lsp.github.io/lsp-mode/page/lsp-pylsp/#server>


## Enabling and using elpy

See: <https://elpy.readthedocs.io/en/latest/introduction.html> for more info on *elpy*.

By default, *elpy* is disabled in favor of LSP, but you can edit
*custom/setup-python.el* to enable it. First, uncomment sections referencing
*elpy*. and then comment all sections in all files referencing *lsp-mode* and
python in *custom/setup-editing.el*.

To make sure elpy is running correctly, *M-X elpy-config*. Note any *warnings*
or missing packages and install them.

If you are using a dedicated virtual environment per project, elpy may warn
about *~/.local/bin* not being in the PATH. You will have to either: modify your PATH
variable before starting emacs, or stop running emacs from the virtual
environment.

To modify your path, add a line like the following to your *~/.bashrc*:

```bash
export PATH="$PATH:$HOME/.local/bin"
```

## Adding and configuring additional Python packages: autopep8, yapf, jedi, rope, black, flake8

These pip packages provide features used by *elpy* and/or *python-lsp-server*,
but are handy on their own.

* *autopep8* helps elpy enforce compliance with the Python Pep-8 coding standards
by underlining in red all non-compliant code. See:
<http://paetzke.me/project/py-autopep8.el>.

* *flake8* is the linter static analysis engine used by autopep8.

* *yapf* is used as a more feature completed *autopep8* with a slightly different
and more hands-on approach to enforcing code-style beyond pep8 compliance.

In general, you should configure your editor to use 1 of these at a time.

However, you can still install all of them on your machine and have different
linting tools run them as part of your gating process-- both inside or outside
of *emacs*.


To install all python packages supported by Elpy:

```bash
pip install autopep8 jedi rope yapf black flake8 pydocstyle
```

To install all optional packages supported by *python-lsp-server*:

```bash
pip install python-lsp-server[all]

```

Sometimes, you may want to override some of autopep8's style settings, such as
the default line length being set to only allow 80 characters.

Another issue is that pycodestyle enforces W503 and W504 out of the box
when all warnings are enabled.  These two rules actually conflict with each
other. The current best practice in PEP8 is to use W504, as W503 is deprecated.

To change settings, edit *$HOME/.config/pycodestyle* and add the appropriate
ini-file style configuration settings.  The following changes the default line
length from 80 to 160 characters and turns off W503:

```
[pycodestyle]
max_line_length = 160
ignore = W503
```

To override the default pylint settings, create an rc file in your home
directory or project root called *.pylintrc*:

```
[MASTER]

persistent=yes

[FORMAT]
max-line-length=160

```

To override settings in flake8, look for file *~/.config/flake8*:
```
[flake8]
max-line-length = 160
```

## Using the python invoke package

Most of my Python projects use a package called *invoke* to execute the creation
of build and release targets. *invoke* is a "task execution tool and library."
It is similar in purpose to *make*, *maven* or Ruby *rake*.

You can install it:

```bash
pip install invoke
```

To setup invoke, you create a tasks.py file in the top directory of your package:


Here is an example *tasks.py* file:

```python
"""Invoke build and compile tasks.

"""
import os
from urllib.request import pathname2url
from invoke import Collection, task
import webbrowser


def open_browser(file_name: str):
    """Open the default browser at a local html file."""
    uri = pathname2url(os.path.abspath(file_name))
    webbrowser.open(f"file://{uri}")

@task
def pip_install_requirements(c):
    """Install dependencies needed to run packagename.

    Runs 'pip install -r requirements.txt'.
    """
    c.run('pip install -r requirements.txt')


@task(pip_install_requirements)
def pip_install_development_requirements(c):
    """Install development dependencies needed to develop packagename.

    Runs 'pip install -r requirements_dev.txt'.
    """
    c.run('pip install -r requirements_dev.txt')


@task(pip_install_development_requirements)
def pip_install_emacs_requirements(c):
    """Install all dependencies needed to develop with emacs as an IDE.

    Runs 'pip install -r requirements_emacs_dev.txt'.
    """
    c.run('pip install -r requirements_emacs_dev.txt')


@task(pip_install_development_requirements, default=True)
def pip_install_dev_mode(c):
    """Install dev environment: required dev packages and also install locally in development mode.

    Runs 'pip install -e .'.
    """
    c.run('pip install -e .')


@task
def clean_release(c):
    """Clean build artifacts produced when creating and releasing the package.

    Runs remove file and directory commands to remove sdist and python egg files and directories.
    """
    c.run('rm -rf build/')
    c.run('rm -rf dist/')
    c.run('rm -rf .eggs/')
    c.run('rm -rf packagename.egg-info/')
    c.run("find . -name '*.egg-info' -exec rm -fr {} +")
    c.run("find . -name '*.egg' -exec rm -f {} +")


@task
def clean_pyc(c):
    """Find and remove stale compiled python files ending in pyc or pyo as well as emacs backup files and __pycache__ directories."""
    c.run("find . -name '*.pyc' -exec rm -f {} +")
    c.run("find . -name '*.pyo' -exec rm -f {} +")
    c.run("find . -name '*~' -exec rm -f {} +")
    c.run("find . -name '__pycache__' -exec rm -fr {} +")


@task
def clean_testing(c):
    """Remove cruft created during testing activities, including stale coverage and pytest output."""
    c.run("rm -rf .tox/")
    c.run("rm -f .coverage")
    c.run("rm -rf htmlcov/")
    c.run("rm -rf .pytest_cache")


@task
def clean_install(c):
    """Uninstall packagename, regardless of original installation mode or method.

    Runs 'pip uninstall -y packagename'.
    """
    c.run("pip uninstall -y packagename")


@task(clean_release, clean_pyc, clean_testing, clean_install)
def pristine(c):
    """Uninstall packagename and cleanup everything."""
    pass


@task(default=True)
def unit_test(c):
    """Run unit tests.

    Runs 'python -m unittest'.
    """
    c.run("python -m unittest")


@task
def coverage(c):
    """Run unit tests and collect code coverage statistics.

    Runs:
    'coverage run --source packagename -m unittest discover'
    'coverage report -m'
    'coverage html'
    Then attempts to start a local browser pointed at ./htmlcov/index.html.
    """
    c.run("coverage run --source packagename -m unittest discover")
    c.run("coverage report -m")
    c.run("coverage html")
    open_browser("./htmlcov/index.html")


@task
def lint_bin(c):
    """Run pylint code quality static analyzer on the contents of the ./bin directory."""
    c.run("pylint --fail-under=8 ./bin")


@task(lint_bin)
def lint(c):
    """Run pylint code quality static analyzer on the contents of the ./packagename and ./bin directories."""
    c.run("pylint --fail-under=8 ./packagename")


@task(lint)
def lint_tests(c):
    """Run pylint code quality static analyzer on the contents of the ./packagename, ./bin and ./test directories."""
    c.run("pylint --fail-under=2 ./tests")


@task
def security(c):
    """Run bandit security static analyzer on the contents of the ./packagename directory."""
    c.run("bandit -r packagename")


@task
def docs(c):
    """Generate API documentation in markdown format and overlay ./docs directory.

    Done via pdoc3.
    """
    c.run("pdoc3 --pdf packagename > docs/README.md")


@task(docs, default=True)
def release(c):
    """Build a package suitable for redistribution.

    Package can be uploaded to a PyPi compatible server such as an Azure DevOps Artifacts repository.

    Runs 'python setup.py sdist'
    """
    c.run("python setup.py sdist")


@task(docs)
def install_local(c):
    """Install packagename locally via pip, see build.release and develop.install before running.

    This does not install in dev mode and is used mainly for testing. Use build.release to promote and develop.install to develop.

    Runs 'pip install .'.
    """
    c.run("pip install ./")

ns = Collection()

quality = Collection('quality')
quality.add_task(coverage)
quality.add_task(lint)
quality.add_task(lint_tests)
quality.add_task(security)
quality.add_task(unit_test)

build = Collection('build')
build.add_task(clean_install, 'uninstall')
build.add_task(pristine)
build.add_task(install_local)
build.add_task(release)

develop = Collection('develop')
develop.add_task(pip_install_emacs_requirements, 'install-emacs')
develop.add_task(pip_install_dev_mode, 'install')

ns.add_collection(quality)
ns.add_collection(build)
ns.add_collection(develop)

```

More info on *invoke*: <https://www.pyinvoke.org>


# General emacs Environment Setup

What follows are instructions that I use to setup *emacs* in a GNU/Linux
environment. These are emacs settings that have to be setup in your GNU/Linux
shell environment, they are not installed or configured as part of this
repository.

I set up *emacs* to be the default editor in my *bash* shell environment. I do
this by adding the following to file *~/.bashrc*:

```bash
export VISUAL='emacsclient -c --alternate-editor='
export EDITOR='emacsclient -t --alternate-editor='
alias e="${VISUAL}"
```

I like to run *emacs* in daemon mode (as a server/service). This is a better way
to run *emacs* on modern systems, since it shares resources between instances of
*emacs*. Each client instance will then integrate with the others, instead
of each instance being able to over-write the same files since they don't
know about each other.

By default, *emacsclient* starts a new client that connects to the existing
emacs daemon running in the background. A daemon is another way of saying a
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
what they were originally intended for, but that usage is archaic for most users
anyway: unless your primary display screen consists of a teletype machine with a
300 baud modem and a printer instead of a display, or your are developing
kernels/drivers that assume such things for debugging purposes. Regardless, you
should understand what these two variables mean to other UNIX era legacy
programs before you decide to mimic this setup, or you may run into issues when
using legacy programs.

Regardless of the intended original use, window environments 
like GNOME and KDE are in the habit of looking for the VISUAL environment
variable to tell them what default editor to use. Command line terminal programs
are firmly in the habit of using EDITOR to tell them what editor to start.

We are passing *-t* to run a terminal version when EDITOR is used by some other
program. This starts a new *emacs* client inside the terminal window.

When *VISUAL* is used, we create a new X window (actually, a *frame* in *emacs*
parlance) via the *-c* option. Without this, *emacs* would try and find an
existing X window and change the contents of that window. I prefer to have a new
window (er... frame) for everything I explicitly open and to leave my existing
windows/frames alone.

Note that these commands and options are specific to recent versions of
*emacs*. Older versions of *emacs* and *emacsclient* take different
options. Very old versions of *emacs* don't have an *emacsclient*, or call it by
a different name.


## Systemd integration

You may take your setup one step further and have your emacs daemon managed by
*systemd*, so that it starts up automatically when the machine
starts. Instructions to do so are here:
<https://nilsdeppe.com/posts/emacs-c++-ide2>. I don't do this as it seems
overkill for my use case.

## *emacs* daemon startup on Desktop load

Optionally, you could also start *emacs* in dameon mode when your X desktop
starts. Instructions for doing so are specific to the desktop or X environment
that you use, but usually involve something along the lines of running a "Startup
Programs" option under your desktop environments control panel or settings.

## Making emacs your tiling window manager

Another option worth consideration is just making *emacs* your window
manager/window environment.  See: <https://github.com/ch11ng/exwm>.

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



# Setting up the Kenesis Advantage II keyboard for emacs

This sections contains configuration notes specific to the Advantage II keyboard.

Note that the Keyboard manual is found here:

<https://kinesis-ergo.com/wp-content/uploads/Adv2-Users-Manual-fw1.0.517-4-24-20.pdf>


## What does *keypad layer* mean?

Well, a layer you have used on any keyboard is the *shift* layer. The shift key
temporarily enters this layer while held down. The capslock toggles turning it
off and on-- without having to keep holding down the shift key. Obviously, the
shift layer makes the keys print capitals instead of lower case and symbols
instead of numbers. Similarly, the number lock key locks the 10 key to emit
numbers.

In the case of the Advantage II keypad layer, the *keypd* button at the top
right triggers this separate layer. It is used out of the box to let you ten key
on this smaller keyboard. Like laptop keyboards, this keyboard doesn't have a
physically separate keypad placed over to the right for 10 keying.  The keypad
layer turns the keys normally used for entering letters on the right side of the
keyboard into a 10 key layer. So key *u* on a qwerty version of the Advantage II
keyboard becomes *7*, and so forth. Out-of-the box, the left side of the
keyboard remains bound to lowercase letters while the right side is now a
10-key.

## What is a modifier key?

In the example above, the *Shift* key is a modifier key. Pressing it changes the
functionality of the keys pressed by changing the keyboard layer. Older
computers frequently used keyboards with many more modifier keys than we
currently have. These modifier keys were often larger and easier to reach. They
were much more ergonomic to use than the the modern "Control" key which requires
the use of your pinky finger-- a horrible finger from an ergonomic standpoint as
it is the smallest and most fragile.

*emacs* was developed on an older system that had a keyboard known as the *space
cadet* keyboard because it had so many modifier keys that it looked like some
control panel in a spaceship.


## What is a macro?

A macro is a stored series of key presses that can be replayed later on.

## What does binding a macro mean?

Binding means associating a macro or function with a key combination. Normally,
typing c makes the letter "c" appear on the screen of our editor. If we bound a
macro to "c", it would instead type whatever the macro told it to type instead
of *c*. For example, if the programmed macro told it to type "Hello", it would
output *Hello* instead of *c*. That wouldn't be very usable. Usually macros and
lisp functions are bound to modifier key combinations called *chords*. For
example, *Cnt-X, Cnt-S* saves the contents of an *emacs* buffer to disk. In this
case, an *emacs* function is bound to the chorded key combination: *Cnt-X,
Cnt-S*. You could rebind it to any other key in *emacs* if you really wanted
to. For example, *evil* is an *emacs* package to make emacs more useable for
*vi/vim* users. Among other things, it provides alternate keybindings that mimic
*vi/vim*.

## What are emacs macros?

*emacs* means *editor macros*. It is an editor that supports saving macros and
lisp functions in files, reading them when the editor was started, binding them
to key chords according to setup files, and then replaying the macros and
functions when the bound chords were typed. This was a core concept of the
editor and was considered a "killer-feature" of its day. It differentiated
*emacs* from most other editors, where a keys meaning was hard-coded and could
not be re-configured.

## What are Kenesis keyboard macros?

In the case of this keyboard, we are not talking about *emacs* macros. Instead,
we are talking about a keyboard feature of the Kenesis keyboard that
allows you to save macros into the keyboard's memory and then retrieve them and
replay them without retyping them. Kenesis added this feature as an ergonomic
way to save keyboard users from having to type difficult sequences over and over
again. So when we talk about these macros, we are not talking about storing
macros inside of *emacs* itself, but inside the keyboard's memory.

A keyboard stored macro will simply replay to the operating system, and the
macros stored could be for anything: *Microsoft Word*, or a button-combo for a
video game. I just happen to save macros in my keyboard that type out *emacs*
*chords*. In case you are wondering: Yes, I could program keyboard macros that in
turn called custom written emacs macros. Which is very meta.

So why do this in a keyboard instead of just using *emacs* chords directly?

Because *emacs* only has so many high quality chord combinations to bind its own
macros too. A downside of keyboards having few usable modifier keys is that you
eventually have macros and functions bound to weird un-ergonomic keyboard
combinations that aren't really usable:
*C-M-Spc-some-weird-thing-you-have-to-type-and-wont-remember-ever* is one of the
biggest problems with *emacs*, or any similar editor that reaches a high level
of complexity.

The traditional *IDE* way to handle this is to have large drop-down lists and
icons everywhere-- cluttering up your screen. This required you to cycle through
them with a mouse or hot keys and arrow keys.

More modern approaches use a search to just find the command you want to run as
you type something resembling it into the search window, which is much
better. *emacs* has supported such *completions* for decades at least.

Quicker still would be to extend the amount of simple to remember key
combinations-- so you have more usable keys to bind to. In other words, we need
more simple to use modifier keys, like the original keyboard used by the first
*emacs* users.


## Rebinding/re-programming keys in the keyboard

I reprogram the keypad layer to bind programmed macros to the left side keys
which are not really useful in the keypad layer. When I am in the keypad layer,
pressing specific keys on the left side will run specific keyboard macros
instead of just emitting the normal characters. I avoid reprogramming the
right-side keys in-case I ever want to 10-key. This means the custom keybindings
don't interfere with other normal uses of the keyboard, or with the 10-key mode
in the keypad layer.

The default macros I have stored and bound to the keypad layer's left side run
complex chorded *emacs* commands that I don't like remembering or typing
over-and-over. A list of these keyboard macros follows in the next section.

In that section, note that the *kp* prefix that I use indicates that we must be
in the keypad layer and then press the key combination that follows. Thus,
*kp-a* means pressing the *a* key when in the keypad layer.

You can do this with any Kenesis Adavantage keyboard by pressing *keypd* to lock
the keypad layer on, pressing the *a* key-- and then pressing the *keypd* key
again to exit the keypad layer.

So far, that is not an improvement over using poorly chorded *emacs* keybindings
and commands. What is worse is that the *keypd* key is way up to the top right
of the keyboard and is a second-class tiny foamy-chicklet-style button that you
cannot find by touch. It is not even a real modifier key, but a toggle like
*caps lock*. So why bother with binding macros to this keypad layer?

Kenesis offers a series of foot pedal controllers. I use one of these as a big
giant modifier key to toggle turning the keypad layer on and off.  Pressing the
pedal with my foot activates the keypad layer for as long as I hold my foot
down. This is like the shift key engaging the shift layer only while it is held
down.

So when I press and hold the footpedal and hit the c key (*kp-c*), the keyboard
runs an internal macro that I have programmed. Instead of emitting *c*, it now
"types": *Cntl-c p c*. This is the *chord* used by *emacs* projectile mode to
compile a project. Holding the foot-pedal and hitting the "c" key is much
quicker than typing *Cntrl-c p c -> Enter*. It is far better than reaching for
the rat and clicking on a tiny gear icon in some GUI IDE.

Of course, for this to work you first must program the macros into your Kenesis
keyboard. Which means you must have a Kenesis keyboard. To use the keypad layer
with a modifier key, you must also have something like a programmable foot
pedal.

If you keyboard professionally, it is worth investing in these items *before*
you get repetitive stress injuries, regardless of what editor or IDE you use. In
particular, the *Control* key used by any power-user on any system is in the
most terrible place possible on standard keyboards. Hitting the *control* key
over and over will give anyone an RSI over a lifetime of professional use.

Here are the macros I have programmed into my keyboard and what they do:

## Keypad layer to emacs command mapping

| Keypad Command | command | emacs keybinding (if bound) |
| -------------  |-------------| -----|
| **Cursor movement keys** |   |  |
| *kp-a* | beginning-of-defun      | C-M-a |
| *kp-e* | end-of-defun            | C-M-e |
| *kp-f*  | forward-sexp     | C-M-f |
| *kp-b*  | backward-sexp    | C-M-b |
| *kp-h*  |  mark-defun  | C-M-h |
| *kp-Space* | mark-sexp     | C-M-<SPC> |
| **Spell Checking** | | |
| *kp-s* |  ispell-word | (Meta-$) |
| *kp-NumRow4* | flyspell-mode | M-x flyspell-mode |
| *kp-LShift-NumRow4* | flyspell-prog-mode | M-x flyspell-prog-mode |
| **dired-sidebar** |    |    |
| *kp-q* | dired-sidebar-toggle-sidebar |  |
| **Projectile commands** | | |
| *kp-LCtrl-g* | grep in projectile project   | C-c p s g |
| *kp-LCtrl-c* | projectile-compile-project |  C-c p c |
| *kp-LCtrl-t* | projectile-compile-test      |  C-c p P |
| *kp-LCtrl-p* | projectile-package-project   | C-c p K  |
| *kp-LCtrl-i* | projectile-install-project   | C-c p L  |
| *kp-LCtrl-r* | Simple refactoring with text replace in current project | C-c p r |
| *kp-LCtrl-f* | Jump to any file in the project | C-c p f |
| *kp-LCtrl-d* | Jump to any directory in the project | C-c p d |
| *kp-LCtrl-b* | List buffers local to current project | C-c p b |
| *kp-LCtrl-e* | Jump to recently visited files in project | C-c p e |
| *kp-LCtrl-o* | Multi-occur in project buffers | C-c p o |
| *kp-LCtrl-s* | Switch visited projects (visited once and Projectile remembers) | C-c p p |
| *kp-LCtrl-a* | Switch between header and detail files .h and .c or .cpp | C-c p a |
| **lsp commands** |   |  |
| *kp-LAlt-LShift-r* | lsp-workspace-restart  | s-l w r |
| *kp-LAlt-LShift-q* | lsp-workspace-shutdown  | s-l w q  |
| *kp-LAlt-r* | lsp-rename |  S-l r r |
| *kp-LAlt-f* | lsp-format-region  |  |
| *kp-LAlt-LShift-f* | lsp-format-buffer |  S-l = = |
| *kp-LAlt-d* | lsp-find-definition |  S-l g g |
| *kp-LAlt-t* | lsp-find-type-definition | S-l g t |
| *kp-LAlt-left arrow* | lsp-find-references | S-l g r |
| *kp-LAlt-right arrow* | lsp-find-declaration | S-l g d |
| *kp-LAlt-down arrow* | lsp-treemacs-call-hierarchy | S-l g h |
| *kp-LAlt-i* | lsp-find-implementation | S-l g i |
| *kp-LAlt-Space* | lsp-signature-activate | C-S-SPC |
| *kp-LAlt-h* | lsp-describe-thing-at-point | S-l h h |
| *kp-LAlt-s* | lsp-treemacs-symbols-goto-symbol |  |

## Raw keybindings

Below are the raw commands that are saved to a text file on the keyboard to
program the above macros (read the keyboard owner's manual to see how to do this
as it differs from keyboard versions). Note that I don't use Super short-cuts
but call the bound function with *M-x*. This is because I often run in a virtual
machine, and in such cases the super modifier is handled by Windows and doesn't
get passed to the VM.

```
[rwin]>[ralt]
[kp-rwin]>[kp-ralt]
{kp-a}>{-lctrl}{-lalt}{a}{+lalt}{+lctrl}
{kp-e}>{-lctrl}{-lalt}{e}{+lctrl}{+lalt}
{kp-f}>{-kp-lctrl}{-kp-lalt}{kp-f}{+kp-lalt}{+kp-lctrl}
{kp-b}>{-kp-lctrl}{-kp-lalt}{kp-b}{+kp-lalt}{+kp-lctrl}
{kp-h}>{-lctrl}{-lalt}{h}{+lalt}{+lctrl}
{kp0}>{-lctrl}{-lalt}{space}{+lalt}{+lctrl}
{kp-s}>{-lalt}{-lshift}{4}{+lshift}{+lalt}
{kp-4}>{-lalt}{x}{+lalt}{d125}{f}{l}{y}{s}{p}{e}{l}{l}{hyphen}{m}{o}{d}{e}{enter}
{kp-lshift}{kp-4}>{-lalt}{x}{+lalt}{d125}{f}{l}{y}{s}{p}{e}{l}{l}{hyphen}{p}{r}{o}{g}{hyphen}{m}{o}{d}{e}{enter}
{kp-q}>{-lalt}{x}{+lalt}{d125}{d}{i}{r}{e}{d}{hyphen}{s}{i}{d}{e}{b}{a}{r}{hyphen}{t}{o}{g}{g}{l}{e}{hyphen}{s}{i}{d}{e}{b}{a}{r}{enter}
{kp-lctrl}{kp-g}>{-lctrl}{c}{+lctrl}{p}{s}{g}
{kp-lctrl}{kp-c}>{-lctrl}{c}{+lctrl}{p}{c}
{kp-lctrl}{kp-t}>{-lctrl}{c}{+lctrl}{p}{-lshift}{p}{+lshift}{enter}
{kp-lctrl}{kpmin}>{-lctrl}{c}{+lctrl}{p}{-lshift}{K}{+lshift}{enter}
{kp-lctrl}{kp8}>{-lctrl}{c}{+lctrl}{p}{-lshift}{L}{+lshift}{enter}
{kp-lctrl}{kp-r}>{-lctrl}{c}{+lctrl}{p}{r}
{kp-lctrl}{kp-f}>{-lctrl}{c}{+lctrl}{p}{f}
{kp-lctrl}{kp-d}>{-lctrl}{c}{+lctrl}{p}{d}
{kp-lctrl}{kp-b}>{-lctrl}{c}{+lctrl}{p}{b}
{kp-lctrl}{kp-e}>{-lctrl}{c}{+lctrl}{p}{e}
{kp-lctrl}{kp9}>{-lctrl}{c}{+lctrl}{p}{o}
{kp-lctrl}{kp-s}>{-lctrl}{c}{+lctrl}{p}{p}
{kp-lctrl}{kp-a}>{-lctrl}{c}{+lctrl}{p}{a}
{kp-lalt}{kp-lshift}{kp-r}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{w}{o}{r}{k}{s}{p}{a}{c}{e}{hyphen}{r}{e}{s}{t}{a}{r}{t}{enter}
{kp-lalt}{kp-lshift}{kp-q}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{w}{o}{r}{k}{s}{p}{a}{c}{e}{hyphen}{s}{h}{u}{t}{d}{o}{w}{n}{enter}
{kp-lalt}{kp-r}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{r}{e}{n}{a}{m}{e}{enter}
{kp-lalt}{kp-f}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{f}{o}{r}{m}{a}{t}{hyphen}{r}{e}{g}{i}{o}{n}{enter}
{kp-lalt}{kp-lshift}{kp-f}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{f}{o}{r}{m}{a}{t}{hyphen}{b}{u}{f}{f}{e}{r}{enter}
{kp-lalt}{kp-d}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{f}{i}{n}{d}{hyphen}{d}{e}{f}{i}{n}{i}{t}{i}{o}{n}{enter}
{kp-lalt}{kp-t}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{f}{i}{n}{d}{hyphen}{t}{y}{p}{e}{hyphen}{d}{e}{f}{i}{n}{i}{t}{i}{o}{n}{enter}
{kp-lalt}{kp-left}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{f}{i}{n}{d}{hyphen}{r}{e}{f}{e}{r}{e}{n}{c}{e}{s}{enter}
{kp-lalt}{kp-right}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{f}{i}{n}{d}{hyphen}{d}{e}{c}{l}{a}{r}{a}{t}{i}{o}{n}{enter}
{kp-lalt}{kp-down}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{t}{r}{e}{e}{m}{a}{c}{s}{hyphen}{c}{a}{l}{l}{hyphen}{h}{i}{e}{r}{a}{r}{c}{h}{y}{enter}
{kp-lalt}{kp8}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{f}{i}{n}{d}{hyphen}{i}{m}{p}{l}{e}{m}{e}{n}{t}{a}{t}{i}{o}{n}{enter}
{kp-lalt}{kp0}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{s}{i}{g}{n}{a}{t}{u}{r}{e}{hyphen}{a}{c}{t}{i}{v}{a}{t}{e}{enter}
{kp-lalt}{kp-h}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{d}{e}{s}{c}{r}{i}{b}{e}{hyphen}{t}{h}{i}{n}{g}{hyphen}{a}{t}{hypen}{p}{o}{i}{n}{t}{enter}
{kp-lalt}{kp-s}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{t}{r}{e}{e}{m}{a}{c}{s}{hyphen}{s}{y}{m}{b}{o}{l}{s}{hyphen}{g}{o}{t}{o}{hyphen}{s}{y}{m}{b}{o}{l}{enter}
```
