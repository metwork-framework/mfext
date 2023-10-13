include ../../../adm/root.mk
include ../../package.mk

export NAME=nodejs
export VERSION=16.15.1
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=daac0e498f44fd04b60a9d8fe62a50dd
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
