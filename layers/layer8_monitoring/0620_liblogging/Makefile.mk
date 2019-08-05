include ../../../adm/root.mk
include ../../package.mk

export NAME=liblogging
export VERSION=1.0.6
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=7ddd8e5e8dfdede9fdd8578508c76827
DESCRIPTION=\
an easy to use and lightweight signal-safe logging library
WEBSITE=https://github.com/rsyslog/liblogging
LICENSE=BSD

all:: $(PREFIX)/lib/liblogging-stdlog.so
$(PREFIX)/lib/liblogging-stdlog.so:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	# autogen.sh seems to launch ./configure without arguments... (if I add some arguments to autogen.sh, it does not seem to work)
	cd build/$(NAME)-$(VERSION) && sh autogen.sh || true
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) OPTIONS="--enable-journal=no --enable-man-pages=no" configure build install
