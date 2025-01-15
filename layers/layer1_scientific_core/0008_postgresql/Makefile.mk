include ../../../adm/root.mk
include ../../package.mk

export NAME=postgresql
export VERSION=17.2
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=09113b33865a873443aca6feda634b0f
DESCRIPTION=\
POSTGRESQL is an object-relational database system
WEBSITE=http://postgresql.org/
LICENSE=PostgreSQL (similar MIT or BSD)

#Other supports suggested by M. Rechte : --with-icu --with-llvm, --with-perl, --with-systemd, --with-system-tzdata=/usr/share/zoneinfo (?)
#But requiring more devels, so not set for the time being

all:: $(PREFIX)/bin/psql
$(PREFIX)/bin/psql:
	$(MAKE) --file=../../Makefile.standard MAKELEVEL=0 PREFIX=$(PREFIX) OPTIONS="--with-includes=$(PREFIX)/include:$(PREFIX)/../core/include --with-libraries=$(PREFIX)/lib:$(PREFIX)/../core/lib --with-libxml --with-ssl=openssl --with-python --with-ldap --with-libxslt --with-icu=no --enable-nls --with-uuid=e2fs --with-zstd --with-lz4" download uncompress configure build install
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
