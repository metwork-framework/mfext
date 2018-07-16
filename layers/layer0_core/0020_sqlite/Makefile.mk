include ../../../adm/root.mk
include ../../package.mk

export NAME=sqlite
export VERSION=autoconf-3080803
export EXTENSION=tar.gz
export CHECKTYPE=NONE
DESCRIPTION=\
SQLITE est un moteur de base de données SQL embarcable (cad que la base est un simple fichier)
WEBSITE=http://sqlite.org/
LICENSE=Domain public

all:: $(PREFIX)/lib/libsqlite3.so
$(PREFIX)/lib/libsqlite3.so: 
	$(MAKE) --file=../../Makefile.standard OPTIONS="--enable-shared --disable-static" EXTRACFLAGS="-DSQLITE_ENABLE_COLUMN_METADATA" download uncompress configure build install
