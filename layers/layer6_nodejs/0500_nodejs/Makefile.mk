include ../../../adm/root.mk
include ../../package.mk

export NAME=nodejs
<<<<<<< HEAD
export VERSION=20.9.0
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=be9e41bd44d75d8021e0ef5738a7d20f
=======
export VERSION=22.16.0
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=63a54e53d8833f4b70d1d3256002eb89
>>>>>>> 51fccbf (feat: bump nodejs from 20.19.2 to 22.16.0 (#2334))
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
