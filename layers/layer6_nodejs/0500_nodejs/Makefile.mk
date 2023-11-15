include ../../../adm/root.mk
include ../../package.mk

export NAME=nodejs
export VERSION=20.9.0
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=be9e41bd44d75d8021e0ef5738a7d20f
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
