include ../../../adm/root.mk
include ../../package.mk

export NAME=pg_uuidv7
export VERSION=1.6.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=be762db1c4b017ec83d0aa6023c88e3e
DESCRIPTION=\
A tiny Postgres extension to create valid version 7 UUIDs in Postgres
WEBSITE=https://pgxn.org/dist/pg_uuidv7/
LICENSE=Mozilla Public License Version 2.0

all:: $(PREFIX)/lib/postgresql/pg_uuidv7.so

$(PREFIX)/lib/postgresql/pg_uuidv7.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress build install
