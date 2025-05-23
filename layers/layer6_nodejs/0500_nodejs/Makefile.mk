include ../../../adm/root.mk
include ../../package.mk

export NAME=nodejs
export VERSION=20.19.2
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=b0a5c2f38be126540fe656772f9637b9
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
