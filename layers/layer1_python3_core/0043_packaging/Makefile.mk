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

all:: $(PYTHON3_SITE_PACKAGES)/$(NAME)-$(VERSION)-py$(PYTHON3_SHORT_VERSION).egg
$(PYTHON3_SITE_PACKAGES)/$(NAME)-$(VERSION)-py$(PYTHON3_SHORT_VERSION).egg:
	$(MAKE) --file=../../Makefile.standard download uncompress
	$(MAKE) --file=../../Makefile.standard python3build python3install
