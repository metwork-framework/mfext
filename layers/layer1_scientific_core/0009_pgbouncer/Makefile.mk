include ../../../adm/root.mk
include ../../package.mk

export NAME=pgbouncer
export VERSION=1.23.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=44c0756d2f42ed31ee77383f59de6144
DESCRIPTION=\
PGBOUNCER is a lightweight connection pooler for PostgreSQL
WEBSITE=https://www.pgbouncer.org/
LICENSE=ISC

all:: $(PREFIX)/bin/pgbouncer

$(PREFIX)/bin/pgbouncer:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--with-openssl=$(PREFIX)/../core" download uncompress configure build install
