include ../../../adm/root.mk
include ../../package.mk

export NAME=nodejs
export VERSION=22.23.4
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=ee9c6b5d24f047740aaa952a3d6212f4
DESCRIPTION=\
Node.js is a JavaScript runtime built on Chrome s V8 JavaScript engine. \
npm, provided with Node.js, is a software registry used to share and borrow packages, \
and to manage development as well.
WEBSITE=http://nodejs.org
LICENSE=X11

all:: $(PREFIX)/bin/node
$(PREFIX)/bin/node:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress
	cd build/node-v$(VERSION)-linux-x64 && cp -Rf * $(PREFIX)/
