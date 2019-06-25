include ../../../adm/root.mk
include ../../package.mk

export NAME=certifi
export VERSION=2019.3.9
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=76381d19d0a1171fecb2d1002b81424e
DESCRIPTION=\
Python package for providing Mozilla s CA Bundle (patched for centos)
WEBSITE=https://certifi.io
LICENSE=MPL

all:: $(PYTHON2_SITE_PACKAGES)/$(NAME)-$(VERSION)-py$(PYTHON2_SHORT_VERSION).egg
$(PYTHON2_SITE_PACKAGES)/$(NAME)-$(VERSION)-py$(PYTHON2_SHORT_VERSION).egg:
	$(MAKE) --file=../../Makefile.standard download uncompress python2build python2install
