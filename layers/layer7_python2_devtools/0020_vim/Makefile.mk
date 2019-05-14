include ../../../adm/root.mk
include ../../package.mk

export NAME=vim
export VERSION=8.0.069
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=457543a7754b0d3c1c0aa4d4c3bb4070
DESCRIPTION=\
Vim is a highly configurable text editor for efficiently creating and changing any kind of text.
WEBSITE=http://www.vim.org
LICENSE=GPL
SHORT_VERSION=80

all:: $(PREFIX)/bin/vim
$(PREFIX)/bin/vim:
	$(MAKE) --file=../../Makefile.standard EXPLICIT_NAME=vim$(SHORT_VERSION) PREFIX=$(PREFIX) OPTIONS="--enable-gui=no --with-local-dir=$(PREFIX) --with-python-config-dir=$(PREFIX)/../python2_core/lib/python$(PYTHON2_SHORT_VERSION)/config --enable-pythoninterp=dynamic --enable-multibyte --with-features=huge --enable-cscope" download uncompress configure build install
