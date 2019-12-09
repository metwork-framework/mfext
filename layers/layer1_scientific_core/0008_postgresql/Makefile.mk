include ../../../adm/root.mk
include ../../package.mk

export NAME=postgresql
export VERSION=12.1
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=2ee1bd4ec5f49363a3f456f07e599b41
DESCRIPTION=\
POSTGRESQL is an object-relational database system
WEBSITE=http://postgresql.org/
LICENSE=PostgreSQL (similar MIT or BSD)

all:: $(PREFIX)/bin/psql
$(PREFIX)/bin/psql:
	$(MAKE) --file=../../Makefile.standard MAKELEVEL=0 PREFIX=$(PREFIX) OPTIONS="--with-includes=$(PREFIX)/include:$(PREFIX)/../core/include --with-libraries=$(PREFIX)/lib:$(PREFIX)/../core/lib --with-libxml --with-openssl" download uncompress configure build install
	cd build/$(NAME)-$(VERSION)/contrib/hstore && make && make install
	cd build/$(NAME)-$(VERSION)/contrib/pg_stat_statements && make && make install
	cd build/$(NAME)-$(VERSION)/contrib/btree_gist && make && make install
	cd build/$(NAME)-$(VERSION)/contrib/postgres_fdw && make && make install
	cd build/$(NAME)-$(VERSION)/contrib/fuzzystrmatch && make && make install
	cd build/$(NAME)-$(VERSION)/contrib/pg_trgm && make && make install
	cd build/$(NAME)-$(VERSION)/contrib/btree_gin && make && make install
	cd build/$(NAME)-$(VERSION)/contrib/pgcrypto && make && make install
