include ../../../adm/root.mk
include ../../package.mk

export NAME=rsyslog
export VERSION=8.1907.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=97682af2b1d87f903458cfb41725fba6
DESCRIPTION=\
RSYSLOG is the rocket-fast system for log processing.
WEBSITE=https://www.rsyslog.com/
LICENSE=GPL

all:: $(PREFIX)/bin/rsyslogd
$(PREFIX)/bin/rsyslogd:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) OPTIONS="--sbindir=$(PREFIX)/bin --disable-klog --disable-libgcrypt --enable-imfile --enable-omprog --enable-omstdout --enable-mmjsonparse --enable-mmutf8fix --enable-elasticsearch" download uncompress configure build install
