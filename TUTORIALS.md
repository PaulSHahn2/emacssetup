# Tutorials & Resources

If you are new to *emacs* you may want to read some tutorials before copying
anyones setup, or just installing a pre-configured distribution of *emacs* like
*doom* or *spacemacs*.

A good place to start is completing the built-in tutorial that covers the
basics. *C-h t* will bring up the tutorial file. This means press and hold the
Control key and press the letter t, then release the Control key.

After finishing the short tutorial, skimming through the official GNU manual for
*emacs* is advised. If the *emacs* manual is installed, you can do read it on
your local machine using the *info* command, or you can read it inside *emacs*
with *C-h r*.  You can also read the online manual in a web browser, for the
most up-to-date information: <https://www.gnu.org/software/emacs/manual/>.

While the official sources are good, other sources help fill-in the details.

Much of this setup has been taken from the sources below over the years and
modified for my specific use.

## emacs from scratch

I would recommend that you first learn *emacs* by setting it up yourself,
instead of using someone else's pre-rolled setup. The System Crafters' video
series and repository serves as a good starting point to walk you through setup
and provides a much more detailed configuration when finished my setup does:

* <https://www.youtube.com/watch?v=74zOY-vgkyw&list=PLEoMzSkcN8oPH1au7H6B7bBJ4ZO7BXjSZ>

There is a time investment required to watch the videos and starting at the
beginning is required, or you will be lost. One reason for this is that the
videos' author manages configuration changes and documentation changes together
in one org-mode documentation file, and then "de-tangles" that file to build his
*emacs* configuration.

This approach is the inverse of the typical Doxygen/JavaDoc/PyDoc. In those
approaches, you create documentation from code comments. In the de-tangle
approach, code is included in-line with the comments. That code is then stitched
together to create your *emacs* configuration file. This allows the newer user
to see the comments explaining what the *elisp* setup code is actually doing,
since most new *emacs* users are not proficient lisp programmers.

When you are done you will have a very powerful setup, but it will be their
setup. You will need to work on it as you go to get to work the way you
want.

If this approach is too time consuming, a simpler video series is available here:

<https://www.youtube.com/channel/UCDEtZ7AKmwS0_GNJog01D2g>

This author's teaching approach doesn't use de-tanglement and starts from
scratch most of the time. It is more concise, but not as thorough as the
previous video series.

## Pre-configured emacs distributions

Another option is to borrow/take someone else's setup, like copying this
repository. This gets you going temporarily, but may come at the expense of you
not knowing how to setup and customize your environment later on.

There are modified distributions of *GNU emacs* that are purpose specific and
configured "out-of-the-box". They won't work with this setup since they provide
their own pre-rolled packages and configuration settings. You may wish to
consider using one of them. A brief list of some of them follows:

**Spacemacs** is geared to *emacs* beginners with *vi/vim* experience:

* <https://www.spacemacs.org/>

**Doom-emacs** is geared to more experienced power users who want a "leaner"
experience than spacemacs:

* <https://github.com/hlissner/doom-emacs>

**Prelude** is a distribution of *emacs* geared "towards simplicity and
reliability". It is more conservative and closer to *emacs*, but with packages
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

LSP stands for something like *language server protocol*. It specifies a
standard for creating independent language servers that provide static analysis
information to clients on code provided to the server by the client. So it runs
in addition to your editor, which need not be *emacs*. *lsp* servers are
frequently used with *Visual Studio Code*, *Sublime* and other editors as well
as *emacs*.

The idea behind *lsp* is to save the engineering effort spent on making static
analysis engines that are married to individual editors and IDE's. Each editor
has to reinvent the wheel for each language it wants to support.

Instead, language logic is moved into a language service that can be used by any
editor with a compatible interface. So editor developers work on editor features
and language server developers write the code to support how to effective use
their particular language. That code can be used with any editor.

*emacs* has support for LSP. *LSP* can be heavy and slow, but *emacs* specific
tools that do the equivalent tasks are also often heavy and slow. Over the
years, many such *emacs* specific tools have lagged behind language features, or
have been abandoned entirely as *emacs* internals changed. *LSP* seems to be
more future proof.

* <https://emacs-lsp.github.io/lsp-mode/>
* <https://www.youtube.com/watch?v=jPXIP46BnNA&list=PLEoMzSkcN8oNvsrtk_iZSb94krGRofFjN&index=3>

Purists have often found the heavy cpu and memory requirements, resulting lag,
and bugs introduced by such IDE features to be a burden they don't want. They
are often happier with a simple programming mode that highlights code and that
is it. Before native-compilation support made these features fast enough to use,
I leaned more to this direction, especially for C++.

## C++ setup resources:

C++ development is actually changing very rapidly. That standards are evolving
and the preferred methods of editing C++ code are changing fast. Because of
these issues, this C++ *emacs* material may be dated by the time you read it.

* <http://tuhdo.github.io/c-ide.html>
* <https://nilsdeppe.com/posts/emacs-c++-ide2>
* <https://www.sandeepnambiar.com/setting-up-emacs-for-c++/>
* <https://trivialfis.github.io/emacs/2017/08/02/C-C++-Development-Environment-on-Emacs.html>


## Python setup resources:

Many options exist to setup a Python environment in *emacs*. I have previously
used *elpy* and currently use *lsp*.

Configuring *lsp-mode* to work with *python-lsp-server*:

* <https://github.com/python-lsp/python-lsp-server>

Using elpy:

* <https://elpy.readthedocs.io/>


## Javascript setup resources:

This section needs work, as it has been a little while since I worked on React
applications.

Resources I have used in the past:

* <https://patrickskiba.com/emacs/2019/09/07/emacs-for-react-dev.html>
* <http://wikemacs.org/wiki/JavaScript>
* <https://emacs-lsp.github.io/lsp-mode/tutorials/reactjs-tutorial/>
