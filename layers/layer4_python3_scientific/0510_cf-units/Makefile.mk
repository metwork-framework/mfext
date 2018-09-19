include ../../../adm/root.mk
include ../../package.mk

export NAME=cf-units
export VERSION=2.0.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=a2a7a97945916082c89ff91b5c33dfae
DESCRIPTION=\
Units of measure as defined by the Climate and Forecast (CF) metadata conventions, supporting Unidata/UCAR UDUNITS-2 library, and the cftime calendar functionality
WEBSITE=https://scitools.org.uk/cf-units
LICENSE=GNU Lesser General Public License (LGPLv3)

all:: $(PREFIX)/lib/python$(PYTHON3_SHORT_VERSION)/site-packages/cf_units-$(VERSION)-py$(PYTHON3_SHORT_VERSION)-linux-x86_64.egg
$(PREFIX)/lib/python$(PYTHON3_SHORT_VERSION)/site-packages/cf_units-$(VERSION)-py$(PYTHON3_SHORT_VERSION)-linux-x86_64.egg:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRACFLAGS="-I$(PREFIX)/../scientific/include" EXTRALDFLAGS="-L$(PREFIX)/../scientific/lib" download uncompress python3build python3install
