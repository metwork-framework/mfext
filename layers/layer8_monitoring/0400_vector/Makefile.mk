include ../../../adm/root.mk
include ../../package.mk

export NAME=vector
export VERSION=0.49.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=0d59188e204901f356ee997d2be295a1
export ARCHIVE=$(NAME)-$(VERSION)-x86_64-unknown-linux-musl.tar.gz
DESCRIPTION=\
Collect, transform, and route all observability data with one simple tool.
WEBSITE=https://vector.dev/
LICENSE=MPL

all:: $(PREFIX)/bin/vector
$(PREFIX)/bin/vector:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	cd build/$(NAME)-x86_64-unknown-linux-musl/bin && cp -f vector $(PREFIX)/bin/vector
