include ../../../adm/root.mk
include ../../package.mk

export NAME=pg_uuidv7
export VERSION=1.7.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=5bbb8d0e70986541ecaaa740aea4f6d5
DESCRIPTION=\
A tiny Postgres extension to create valid version 7 UUIDs in Postgres
WEBSITE=https://pgxn.org/dist/pg_uuidv7/
LICENSE=Mozilla Public License Version 2.0

all:: $(PREFIX)/lib/postgresql/pg_uuidv7.so

$(PREFIX)/lib/postgresql/pg_uuidv7.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress build install
