include ../../../adm/root.mk
include ../../package.mk

export NAME=pgbouncer
export VERSION=1.21.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=2a5a400d55d303e11ff96ab236dc1e66
DESCRIPTION=\
PGBOUNCER is a lightweight connection pooler for PostgreSQL
WEBSITE=https://www.pgbouncer.org/
LICENSE=ISC

all:: $(PREFIX)/bin/pgbouncer

$(PREFIX)/bin/pgbouncer:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--with-openssl=$(PREFIX)/../core" download uncompress configure build install
