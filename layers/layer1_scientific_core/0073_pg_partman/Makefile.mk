include ../../../adm/root.mk
include ../../package.mk

export NAME=pg_partman
export VERSION=5.2.4
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=d4e3c605255f6746056d4db0dc63ad65
DESCRIPTION=\
PG_PARTMAN is a PostGreSQL extension to create and manage both time-based and serial-based table partition sets
WEBSITE=https://github.com/pgpartman/pg_partman
LICENSE=PostgreSQL

all:: $(PREFIX)/share/postgresql/extension/$(NAME)--$(VERSION).sql

$(PREFIX)/share/postgresql/extension/$(NAME)--$(VERSION).sql:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress build install
