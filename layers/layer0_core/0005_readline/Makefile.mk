include ../../../adm/root.mk
include ../../package.mk

export NAME=readline
export VERSION=8.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=7e6c1f16aee3244a69aba6e438295ca3
DESCRIPTION=\
The GNU Readline library provides a set of functions for use by applications\
that allow users to edit command lines as they are typed in. Both Emacs and\
vi editing modes are available. The Readline library includes additional\
functions to maintain a list of previously-entered command lines, to recall\
and perhaps reedit those lines, and perform csh-like history expansion on\
previous commands.
WEBSITE=https://www.gnu.org/software/readline
LICENSE=GNU GPLv3

# Patch readline-link-to-libtinfo.patch was necessary for use with python2
# Should we keep it ?

all::$(PREFIX)/lib/libreadline.so
$(PREFIX)/lib/libreadline.so:
	$(MAKE) --file=../../Makefile.standard OPTIONS="--disable-static" download uncompress configure build install
