include ../../../adm/root.mk
include ../../package.mk

export NAME=sqlite
export VERSION=3.49.1
export TAR_VERSION=3490100
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=8d77d0779bcd9993eaef33431e2e0c30
export EXPLICIT_NAME=$(NAME)-autoconf-$(TAR_VERSION)
DESCRIPTION=\
SQLite is a C-language library that implements a small, fast, self-contained, high-reliability, full-featured, SQL database engine (the database is a file)
WEBSITE=http://sqlite.org/
LICENSE=Domain public

all:: $(PREFIX)/lib/libsqlite3.so
$(PREFIX)/lib/libsqlite3.so: Makefile Makefile.mk sources
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME="$(EXPLICIT_NAME)" OPTIONS="--enable-shared --disable-static" EXTRACFLAGS="-I$(PREFIX)/include -DSQLITE_ENABLE_COLUMN_METADATA" EXTRALDFLAGS="-L$(PREFIX)/lib" download uncompress configure build install
