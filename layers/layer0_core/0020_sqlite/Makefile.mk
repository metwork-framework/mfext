include ../../../adm/root.mk
include ../../package.mk

export NAME=sqlite
export VERSION=3450000
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=d6150f5dc837ae94b7d735f1b611b634
export EXPLICIT_NAME=$(NAME)-autoconf-$(VERSION)
DESCRIPTION=\
SQLite is a C-language library that implements a small, fast, self-contained, high-reliability, full-featured, SQL database engine (the database is a file)
WEBSITE=http://sqlite.org/
LICENSE=Domain public

all:: $(PREFIX)/lib/libsqlite3.so
$(PREFIX)/lib/libsqlite3.so: Makefile Makefile.mk sources
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME="$(EXPLICIT_NAME)" OPTIONS="--enable-shared --disable-static" EXTRACFLAGS="-I$(PREFIX)/include -DSQLITE_ENABLE_COLUMN_METADATA" EXTRALDFLAGS="-L$(PREFIX)/lib" download uncompress configure build install
