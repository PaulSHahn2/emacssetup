# Windows Specific Stuff

This repository has a windows branch that gets updated from time-to-time when I
need to develop on Windows.

*emacs* is a second class citizen in this second class OS. You will need to
install some things to have a chance of getting a full-featured IDE
running. You can either mess with installing *emacs* as a part of a complete
Cygwin, Min32 or Windows UNIX toolkit, or you can try the Windows native version
of *emacs*. I prefer to run *emacs* in the native version. If that doesn't work,
then I install a virtual machine with a Linux flavor in its
entirety. Intermediary solutions with toolkit's typically cause more problems
than they solve, so I avoid them.

To get a *emacs* Windows native version mostly working:

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
