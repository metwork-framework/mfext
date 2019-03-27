include ../../../adm/root.mk
include ../../package.mk

export NAME=udunits
export VERSION=2.2.26
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=5803837c6019236d24a9c9795cc8b462
DESCRIPTION=\
API and utility for arithmetic manipulation of units of physical quantities
WEBSITE=http://www.unidata.ucar.edu/software/udunits
LICENSE=GPLv2 and GPLv3 compatible (derived from BSD with additional patent wording : https://fedoraproject.org/wiki/Licensing/UCAR)

all:: $(PREFIX)/bin/udunits2
$(PREFIX)/bin/udunits2:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--enable-static=no" download uncompress autoreconf configure build install
