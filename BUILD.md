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

Note that on RHEL you will need to enable devtoolset-10 via *scl* each time you
start your sessions, before you can run *emacs*.  I typically also start my
Python virtual environment before starting the *emacs* daemon.
