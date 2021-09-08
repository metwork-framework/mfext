include ../../../adm/root.mk
include ../../package.mk

export NAME=postgresql-airtide
export VERSION=1.0.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=2b51e6714bbcb8170b8e244b3ceda256
DESCRIPTION=\
PostGreSQL airtide is a PostGreSQL extension to calculate barometric tides
Technical Reference : Ray & Ponte, Annales Geophysicae, 2003
WEBSITE=https://angeo.copernicus.org/articles/21/1897/2003/
LICENSE=??

all:: $(PREFIX)/lib/postgresql/postgresql_airtide.so

$(PREFIX)/lib/postgresql/postgresql_airtide.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress configure build install
