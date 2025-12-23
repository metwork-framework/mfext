include ../../../adm/root.mk
include ../../package.mk

export NAME=pgbouncer
export VERSION=1.25.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=db042d282b8cb69fd6429cf5785bb008
DESCRIPTION=\
PGBOUNCER is a lightweight connection pooler for PostgreSQL
WEBSITE=https://www.pgbouncer.org/
LICENSE=ISC

all:: $(PREFIX)/bin/pgbouncer

$(PREFIX)/bin/pgbouncer:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--with-openssl=$(PREFIX)/../core --with-ldap" download uncompress configure build install
