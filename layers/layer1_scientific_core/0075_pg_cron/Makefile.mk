include ../../../adm/root.mk
include ../../package.mk

export NAME=pg_cron
export VERSION=1.6.7
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=9986167f62b21827ced886bccdfd3431
DESCRIPTION=\
PG_CRON is a simple cron-based job scheduler for PostgreSQL (10 or higher) that runs inside the database as an extension
WEBSITE=https://github.com/citusdata/pg_cron
LICENSE=PostgreSQL Licence

all:: $(PREFIX)/lib/postgresql/pg_cron.so

$(PREFIX)/lib/postgresql/pg_cron.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress build install
