include ../../../adm/root.mk
include ../../package.mk

export NAME=pgbouncer
export VERSION=1.24.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=434cbb2db9034d358dddf525e0e5a3dd
DESCRIPTION=\
PGBOUNCER is a lightweight connection pooler for PostgreSQL
WEBSITE=https://www.pgbouncer.org/
LICENSE=ISC

all:: $(PREFIX)/bin/pgbouncer

$(PREFIX)/bin/pgbouncer:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--with-openssl=$(PREFIX)/../core" download uncompress configure build install
