include ../../../adm/root.mk
include ../../package.mk

export NAME=nodejs
export VERSION=10.16.3
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=9a539e6a9c00539a4ce44b71837cb112
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
