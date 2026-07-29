include ../../../adm/root.mk
include ../../package.mk

export NAME=pgbouncer
<<<<<<< HEAD
export VERSION=1.24.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=434cbb2db9034d358dddf525e0e5a3dd
=======
export VERSION=1.25.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=9689b5ec4a60c25dc7791962b2863ca6
>>>>>>> a2ba059 (feat: bump pgbouncer to 1.25.2 (fix high CVE-2026-6664 & CVE-2026-6665) (#2862))
DESCRIPTION=\
PGBOUNCER is a lightweight connection pooler for PostgreSQL
WEBSITE=https://www.pgbouncer.org/
LICENSE=ISC

all:: $(PREFIX)/bin/pgbouncer

$(PREFIX)/bin/pgbouncer:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--with-openssl=$(PREFIX)/../core" download uncompress configure build install
