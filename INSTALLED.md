# Installed packages and a brief summary of what they do

## Philosophy to packages

There are many packages available in *emacs* and many ways to configure each
package. It is dizzying. Many packages compete with each other to do similar
tasks, but in different ways. These packages will often conflict with each
other. It is best to install and use **one new package at a time**. Learn what
each package can do for you and make sure they do not cause any issues before
installing the next package.

Getting packages to play together is a trial and error process. To get them to
use each other seamlessly frequently requires editing this configuration and
setting variables. Often these variables tell one package about another one to
get them to inter-operate the best.

Sometimes, packages conflict with each other and try to take the same
key-bindings and run from the same hooks. If you delve deep into your
configuration, you can often make these packages get along.

Some packages duplicate functionality. One is not always better than another,
they are just tailored to different workflows and personal preferences. You
usually have to use just one of these packages at a time, even if you have
installed more than one of them.

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

This package is included as a built-in in newer versions of *emacs*.

## window-numbering

Allows us to simply switch between windows in a frame with *M-#*, where the
number sign is the number of the window from top to bottom, left to right. See:
<http://nschum.de/src/emacs/window-numbering-mode/>. This is much faster than
using *C-x o* repeatedly.

## Display completion engines

Much of the time, completion lists are too complicated to use a pop-up, like
company.

Emacs comes with a basic completion framework built-in called
 *i-search*. *i-search* displays items in a special buffer called the
 *mini-buffer*.  *i-search* provides tab-style completion to cycle through
 matches. This is similar to what is available in the bash and other shells. I
 used this for 15 years, and it works fairly well. You may never want or need
 more.

Other options with more advanced completion options exist as well-- like helm,
ido, and ivy/counsel.  This setup lets you can choose from the default
*i-search* tab completion, from *helm* or from *ivy-counsel*.  My current
selection is *ivy-counsel*. To change to a different completion method, edit
your *init.el* file and comment out ivy-counsel. The double semi-colon indicates
a comment in e-lisp.

For example, to change the default *ivy/counsel* to *helm*, edit your *init.el*
file:

```lisp
;; use helm completion control
(require 'setup-helm)
;; ivy counsel completion control
;;(require 'setup-ivy-counsel)
```

To disable *ivy/counsel* and *helm* and use the built-in *emacs* i-search
tab-completion, comment all of these entries out:

```lisp
;; helm completion control disabled
;; (require 'setup-helm)
;; ivy counsel completion control disabled
;; (require 'setup-ivy-counsel)
```

### helm & helm-swoop

Why use *helm* and friends over *i-search*?

**helm** is an advanced completion display engine for *emacs* that allows you to
narrow results from provided lists in a frame or buffer. It extends and replaces
the default tab completion that comes out of the box with *emacs*.
<https://emacs-helm.github.io/helm/>

**helm-swoop** uses helm to display matching content in another buffer and replaces the default *emacs i-search*. See
<https://github.com/emacsorphanage/helm-swoop> and
<https://www.emacswiki.org/emacs/HelmSwoop>. This is a helper package used by
other packages and specific configurations when it would be more appropriate to
display the results in a separate buffer (window frame).

Helm is extremely feature rich and mature. When I used helm, I didn't use most
of its functionality. I simply found I had no time to learn it that in depth.

My reason for discontinuing its use mainly centered around the fact that *helm*
is kinda portly, it's look and feel are dated and its key-bindings were not as
intuitive to me as *i-search* or *ivy*. These are admittedly subjective things.

### ivy & counsel

**ivy** is a more recent completion framework for *emacs*. It is considered faster then *helm*, but was originally much more limited. Its features are improved and its speed advantage is probably over-stated. It integrates nicely with *all-the-icons*, providing a clean modern look.

**counsel** is a collection of ivy-enhanced replacement commands for *emacs*. These commands are bound over the default *emacs* commands to provide ivy completion functionality, instead of the *emacs* default tab-completion.

**swiper** uses counsel to display matching content in another buffer and replaces the default *emacs i-search*.

*ivy/counsel/swiper* are currently the default completion frameworks selected.

## projectile, helm-projectile & counsel-projectile

**projectile** is an *emacs* package that adds project management support. This
is similar to how monolithic IDE's provide their own (often IDE specific)
project file format (or use something like *Maven*).  Projectile includes
support for automatic refactoring of code and movement between files within
projects.  Projectile is programming language and tool agnostic and attempts to
recognize development projects of different types that were created by different
tooling. Support for specific project types is modular via the use of tool
specific plugins and extensions.

See: <https://docs.projectile.mx/en/latest/>

**helm-projectile** is an *emacs* package that extends projectile to use helm
completion. See <https://github.com/bbatsov/helm-projectile>.

**counsel-projectile** is an *emacs* package that extends projectile to use
ivy/counsel completion.

Obviously, you will want to install one of these if you use ivy or helm.

## Whitespace management

I include two different packages that can get rid of bad white-space.

1. **ws-bulter:** The enabled default. This is a gentler program that only
   cleans up whitespace in the area you have modified. Everyone else's strange
   whitespacing is left alone. This is the default enabled in most editing and
   programming modes. See: <https://github.com/lewang/ws-butler>.

2. **whitespace-cleanup-mode:** This nukes all erroneous whitespace in the file
   every time you save to disk. It is not on by default, but just installed. See:
   <https://github.com/purcell/whitespace-cleanup-mode>.

### Which whitespace option should you use?

If you are working on legacy code with others, you should probably use
*ws-butler*. Using *whitespace-cleanup-mode* will result in huge commit sizes
that have nothing to do with your core changes. This occurs since you will have
reformatted the entire file every-time you save. If you are on greenfield
development, it should not matter which you use-- *ws-bulter* will keep you safe to
begin with.

If you are refactoring or cleaning up code, then *whitespace-cleanup-mode* may
be a better choice since it lets you aggressively fix bad whitespace.

You can manually start *whitespace-cleanup-mode* on any buffer via *M-x
whitespace-cleanup-mode*. You can set it up to be always on instead of
*ws-bulter* by editing *~/emacs.d/custom/setup-editing.el*. Remove the
lines commenting out *global-whitespace-cleanup-mode*. Then you should also comment
out *ws-butler* (you really only want one of these running at a time).

## volatile-highlights

**volatile-highlights** briefly shows us text that has been altered or pasted
in. The text will appear highlighted until the next keystroke. This provides a
tiny bit more visual context to what we have done. See:
<https://www.emacswiki.org/emacs/VolatileHighlights>.

## yasnippet

**yasnippet** is an abbreviation template system for *emacs*. We create a setup
file with abbreviations and their expanded equivalents. When we type the
abbreviation, we can optionally expand it to the full equivalent text. See:
<https://www.emacswiki.org/emacs/Yasnippet> &
<http://github.com/joaotavora/yasnippet>.

## iedit

**iedit** Let's you edit multiple matching targets simultaneously. See:
<https://github.com/victorhge/iedit>. This is handy, but I often forget it is
installed. *Projectile* and *lsp* refactoring tools are usually better for
development use, such as re-naming a variable.

## markdown & markdown-preview modes

Provides the ability to edit markdown files and see the output of files edited
in a browser. *markdown-preview-mode* tracks changes on-the-fly by starting up a
server and connecting your browser to the servers endpoint. Each time you save a
change to the markdown file, the endpoint is regenerated and displayed in the
browser. *markdown-mode* provides syntax highlighting. See:
<https://www.emacswiki.org/emacs/MarkdownMode>.

## flyspell & flyspell-correct

Provides spell-checking as you go. See: <https://github.com/d12frosted/flyspell-correct>.

## flycheck

Checks syntax for various programming languages as you go. This is used to
display linting results and similar. It also has companion backend language and
tool specific packages that provide it with information.

Some of these work as a backup to *lsp-mode*. For example, *YAML* uses
*flycheck-yamllint* to provide data to *flycheck* about YAML files.

Normally, this configuration will use *lsp-ui* as a backend to *flycheck* to display
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

I have found that unlike other C tagging and *elisp* emacs specific solutions,
the *lsp-mode* server scales decently and is acceptably fast.
See: <https://github.com/emacs-lsp/lsp-mode> and <https://emacs-lsp.github.io/>.

Languages available are listed here: <https://emacs-lsp.github.io/lsp-mode/page/languages/>.

You can edit *custom/setup-editing.el* to disable *lsp-mode* if you do not want this feature.

**lsp-ui** Contains ui features to display results from the lsp server. See:
<https://github.com/emacs-lsp/lsp-ui>

**emacs-ccls** This runs the ccls server (you must install ccls
server). This server provides lsp data for C/C++ & Objective C. See:
<https://github.com/MaskRay/emacs-ccls>.

The current setup enables ccls for C and C++. You can edit *custom/setup-c.el*
to change this.

In order to use the features of ccls and lsp-mode, you will need to have *ccls*
installed.  For detailed instructions on how to install and setup the *ccls*
go here: <https://github.com/MaskRay/ccls/wiki>.

However, a quick guide follows:

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

## Git management

### magit

A full *git* layer for integration of git with emacs. This is very handy and
very well done. See:
<https://magit.vc/manual/magit/Getting-Started.html#Getting-Started>.

### git-gutter

Keeps track of changes to our git version controlled files in a small "gutter"
window on the left of the buffer. See:
<https://github.com/emacsorphanage/git-gutter>.

### git-timemachine

Lets us navigate and interactively view the versions of a git controlled
file. See: <https://github.com/emacsmirror/git-timemachine>.

## Mode line management

I have installed *smart-modeline* and *diminish*. *smart-modeline* refactors the
appearance of the mode-line to make it cleaner and more up-to-date. It is not as
fancy looking as doom modeline or spacemacs mode-lines, but is pretty-much
compatible with any other package.

The *diminish* package selectively gets rid of cruft that accumulates in the
mode-line when you run many modes at once. Most modes put a message in the
mode-line, unfortunately most of these messages don't display anything
interesting or helpful. This is particularly true for minor modes. This lets you
silence that and keeps your mode-line more clutter free.

## editing as root

*sudo-edit* lets you edit a buffer as root via the sudo command.

## organization mode

*org-vcard* and *org-contacts* lets you read in and share contact information
from PIM applications in org mode. At least theoretically. Not really satisfied
with these packages and this is a major reason I have not moved my email back into *emacs*.

*org-caldav* is very nice and syncs your org mode agenda to your remote calendaring applications.

*org-bullets* tidies up your screen to display pretty bullets for different indentation levels.

## Advanced searching and finding: avy & which-key

*avy* lets you find items that you are searching for very quickly. It is best to
search for videos of it in action to understand how it works.

*which-key* is very helpful. When you are typing out a command or key combo,
pausing for more than a moment results in a completion buffer appearing that
shows what the possible key-bindings completions are and what functions they are
bound to. Brief descriptions are provided. It is simply not possible for most to
remember all possible keybindings and this makes using *emacs* simple as can be.

## Javascript and json support via tide and JSX

*emacs 27* provides native support for react and typescript via *JSX*.

The *tide* package further extends this support. See <http://github.com/ananthakumaran/tide>.

## Python packages and setup

Please see: [PYTHONENV.md](PYTHONENV.md).


## Window management

*emacs* can manage x-windows as a window manager. This is selectively enabled when the *XDG_CURRENT_DESKTOP* environment variable is set and when the OS type is GNU Linux.

Please see: [EXWM.md](EXWM.md).
