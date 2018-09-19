include ../../../adm/root.mk
include ../../package.mk

export NAME=nodejs
export VERSION=8.11.2
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=dc2b675234c473c7b37b1076a03120f1
export ARCHIVE=node-v8.11.2-linux-x64.tar.xz
DESCRIPTION=\
Node.js is a JavaScript runtime built on Chrome s V8 JavaScript engine.
WEBSITE=http://nodejs.org
LICENSE=X11

all:: $(PREFIX)/bin/node
$(PREFIX)/bin/node:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress
	cd build/node-v$(VERSION)-linux-x64 && cp -Rf * $(PREFIX)/
