include ../../../adm/root.mk
include ../../package.mk

export NAME=Cartopy
export VERSION=0.13.1
#Version >= 0.14.0 requires proj4 >= 4.9
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=14ee025ee9a23c0790c363cac15fb373
DESCRIPTION=\
Cartopy is a Python package designed for geospatial data processing in order\
to produce maps and other geospatial data analyses.\
Cartopy makes use of the powerful PROJ.4, numpy and shapely libraries and\
includes a programatic interface built on top of Matplotlib for the creation\
of publication quality maps.
WEBSITE=https://scitools.org.uk/cartopy
LICENSE=GNU Lesser General Public License (LGPLv3)

all:: $(PREFIX)/lib/python$(PYTHON3_SHORT_VERSION)/site-packages/Cartopy-0.13.1-py$(PYTHON3_SHORT_VERSION)-linux-x86_64.egg
$(PREFIX)/lib/python$(PYTHON3_SHORT_VERSION)/site-packages/Cartopy-0.13.1-py$(PYTHON3_SHORT_VERSION)-linux-x86_64.egg:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRACFLAGS="-I$(PREFIX)/../scientific_core/include" EXTRALDFLAGS="-L$(PREFIX)/../scientific_core/lib" download uncompress python3build python3install
