include ../../../adm/root.mk
include ../../package.mk

export NAME=pgbouncer
export VERSION=1.25.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=9689b5ec4a60c25dc7791962b2863ca6
DESCRIPTION=\
PGBOUNCER is a lightweight connection pooler for PostgreSQL
WEBSITE=https://www.pgbouncer.org/
LICENSE=ISC

all:: $(PREFIX)/bin/pgbouncer

$(PREFIX)/bin/pgbouncer:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRACFLAGS="-I$(PREFIX)/../core/include" EXTRALDFLAGS="-L$(PREFIX)/../core/lib" OPTIONS="--with-openssl=$(PREFIX)/../core --with-ldap" download uncompress configure build install
