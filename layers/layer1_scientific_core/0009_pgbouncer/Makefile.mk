include ../../../adm/root.mk
include ../../package.mk

export NAME=pgbouncer
export VERSION=1.17.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=b57212a12ba58fe11e934ea2e40bd610
DESCRIPTION=\
PGBOUNCER is a lightweight connection pooler for PostgreSQL
WEBSITE=https://www.pgbouncer.org/
LICENSE=ISC

all:: $(PREFIX)/bin/pgbouncer

$(PREFIX)/bin/pgbouncer:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress configure build install
