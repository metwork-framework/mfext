include ../../../adm/root.mk
include ../../package.mk

PROXY_SET=$(shell _proxy_set.sh)
ifeq ($(PROXY_SET),0)
	unexport http_proxy
	unexport https_proxy
	unexport HTTP_PROXY
	unexport HTTPS_PROXY
endif

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

all:: $(PREFIX)/lib/node_modules/npm/6.1.0.flag
$(PREFIX)/lib/node_modules/npm/6.1.0.flag:
	#strict-ssl = false to work behind the fucking proxy
	npm config set strict-ssl false
	npm install -g npm@6.1.0
	touch $@
