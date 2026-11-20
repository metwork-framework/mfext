include ../../../adm/root.mk
include ../../package.mk

export NAME=nodejs
<<<<<<< HEAD
export VERSION=22.23.4
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=ee9c6b5d24f047740aaa952a3d6212f4
=======
export VERSION=26.13.1
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=57d3a9341569ce57de85abf46071ee0c
>>>>>>> cdc6cb5 (feat: bump nodejs from 26.13.0 to 26.13.1 (fix 7 high CVE))
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
