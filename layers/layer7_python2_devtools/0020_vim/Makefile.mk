include ../../../adm/root.mk
include ../../package.mk

export NAME=vim
export VERSION=8.1
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=1739a1df312305155285f0cfa6118294
DESCRIPTION=\
Vim is a highly configurable text editor for efficiently creating and changing any kind of text.
WEBSITE=http://www.vim.org
LICENSE=GPL
SHORT_VERSION=81

all:: $(PREFIX)/bin/vim
$(PREFIX)/bin/vim:
	$(MAKE) --file=../../Makefile.standard EXPLICIT_NAME=vim$(SHORT_VERSION) PREFIX=$(PREFIX) OPTIONS="--enable-gui=no --with-local-dir=$(PREFIX) --with-python-config-dir=$(PREFIX)/../python2_core/lib/python$(PYTHON2_SHORT_VERSION)/config --enable-pythoninterp=dynamic --enable-multibyte --with-features=huge --enable-cscope" download uncompress configure build install
