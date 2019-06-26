include ../../../adm/root.mk
include ../../package.mk

export NAME=packaging
export VERSION=19.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=96113e08d486bc2c5c7f448195547434
DESCRIPTION=\
Core utilities for Python packages
WEBSITE=https://github.com/pypa/packaging
LICENSE=Python

all:: $(PYTHON2_SITE_PACKAGES)/$(NAME)-$(VERSION)-py$(PYTHON2_SHORT_VERSION).egg-info
$(PYTHON2_SITE_PACKAGES)/$(NAME)-$(VERSION)-py$(PYTHON2_SHORT_VERSION).egg-info:
	$(MAKE) --file=../../Makefile.standard download uncompress
	$(MAKE) --file=../../Makefile.standard python2build python2install
