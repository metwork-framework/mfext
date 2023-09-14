include ../../../adm/root.mk
include ../../package.mk

export NAME=postgresql
export VERSION=15.4
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=f2f861fb99d742cb9c2f8aa46a8a947d
DESCRIPTION=\
POSTGRESQL is an object-relational database system
WEBSITE=http://postgresql.org/
LICENSE=PostgreSQL (similar MIT or BSD)

all:: $(PREFIX)/bin/psql
$(PREFIX)/bin/psql:
	$(MAKE) --file=../../Makefile.standard MAKELEVEL=0 PREFIX=$(PREFIX) OPTIONS="--with-includes=$(PREFIX)/include:$(PREFIX)/../core/include --with-libraries=$(PREFIX)/lib:$(PREFIX)/../core/lib --with-libxml --with-ssl=openssl --with-python --with-ldap --with-libxslt" download uncompress configure build install
	cd build/$(NAME)-$(VERSION)/contrib/hstore && make && make install
	cd build/$(NAME)-$(VERSION)/contrib/pg_stat_statements && make && make install
	cd build/$(NAME)-$(VERSION)/contrib/btree_gist && make && make install
	cd build/$(NAME)-$(VERSION)/contrib/postgres_fdw && make && make install
	cd build/$(NAME)-$(VERSION)/contrib/fuzzystrmatch && make && make install
	cd build/$(NAME)-$(VERSION)/contrib/pg_trgm && make && make install
	cd build/$(NAME)-$(VERSION)/contrib/btree_gin && make && make install
	cd build/$(NAME)-$(VERSION)/contrib/pgcrypto && make && make install
	cd build/$(NAME)-$(VERSION)/contrib/unaccent && make && make install
	cd build/$(NAME)-$(VERSION)/contrib/xml2 && make && make install
