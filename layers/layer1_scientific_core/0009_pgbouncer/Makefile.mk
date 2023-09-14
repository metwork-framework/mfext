include ../../../adm/root.mk
include ../../package.mk

export NAME=pgbouncer
export VERSION=1.20.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=28dbe7001792f22db52184d31248697d
DESCRIPTION=\
PGBOUNCER is a lightweight connection pooler for PostgreSQL
WEBSITE=https://www.pgbouncer.org/
LICENSE=ISC

all:: $(PREFIX)/bin/pgbouncer

$(PREFIX)/bin/pgbouncer:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress configure build install
