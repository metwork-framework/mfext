include ../../../adm/root.mk
include ../../package.mk

export NAME=pgbouncer
export VERSION=1.24.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=456de5f61ca805c5df7ebab39a6f1298
DESCRIPTION=\
PGBOUNCER is a lightweight connection pooler for PostgreSQL
WEBSITE=https://www.pgbouncer.org/
LICENSE=ISC

all:: $(PREFIX)/bin/pgbouncer

$(PREFIX)/bin/pgbouncer:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--with-openssl=$(PREFIX)/../core" download uncompress configure build install
