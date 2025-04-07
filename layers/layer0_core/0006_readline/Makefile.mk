include ../../../adm/root.mk
include ../../package.mk

export NAME=readline
export VERSION=8.2.13
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=05080bf3801e6874bb115cd6700b708f
DESCRIPTION=\
The GNU Readline library provides a set of functions for use by applications\
that allow users to edit command lines as they are typed in. Both Emacs and\
vi editing modes are available. The Readline library includes additional\
functions to maintain a list of previously-entered command lines, to recall\
and perhaps reedit those lines, and perform csh-like history expansion on\
previous commands.
WEBSITE=https://www.gnu.org/software/readline
LICENSE=GNU GPLv3

all::$(PREFIX)/lib/libreadline.so
$(PREFIX)/lib/libreadline.so:
	$(MAKE) --file=../../Makefile.standard OPTIONS="--enable-static=no" download uncompress configure build install
