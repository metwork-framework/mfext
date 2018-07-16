include ../../../adm/root.mk
include ../../package.mk

export NAME=packaging
export VERSION=16.8
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=02c9a248368c7b9d3236cac349a67825
DESCRIPTION=\
Core utilities for Python packages
WEBSITE=https://github.com/pypa/packaging
LICENSE=Python

all:: $(PYTHON2_SITE_PACKAGES)/$(NAME)-$(VERSION)-py$(PYTHON2_SHORT_VERSION).egg-info
$(PYTHON2_SITE_PACKAGES)/$(NAME)-$(VERSION)-py$(PYTHON2_SHORT_VERSION).egg-info:
	$(MAKE) --file=../../Makefile.standard download uncompress
	$(MAKE) --file=../../Makefile.standard python2build python2install
