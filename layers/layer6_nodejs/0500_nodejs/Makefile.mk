include ../../../adm/root.mk
include ../../package.mk

export NAME=nodejs
export VERSION=26.13.0
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=3fb8f80f9846f6b0e2182597b359cf5f
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
