include ../../../adm/root.mk
include ../../package.mk

export NAME=vector
export VERSION=0.11.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=6411d842ee85949c7058a890e0ec7923
export ARCHIVE=$(NAME)-$(VERSION)-x86_64-unknown-linux-musl.tar.gz
DESCRIPTION=\
Collect, transform, and route all observability data with one simple tool.
WEBSITE=https://vector.dev/
LICENSE=MPL

all:: $(PREFIX)/bin/vector
$(PREFIX)/bin/vector:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	cd build/$(NAME)-x86_64-unknown-linux-musl/bin && cp -f vector $(PREFIX)/bin/vector
