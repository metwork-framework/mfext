include ../../../adm/root.mk
include ../../package.mk

export NAME=certifi
export VERSION=2018.10.15
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=3f4ca75a66bc65fea0693b8040f66d13
DESCRIPTION=\
Python package for providing Mozilla s CA Bundle (patched for centos)
WEBSITE=https://certifi.io
LICENSE=MPL

all:: $(PYTHON3_SITE_PACKAGES)/$(NAME)-$(VERSION)-py$(PYTHON3_SHORT_VERSION).egg
$(PYTHON3_SITE_PACKAGES)/$(NAME)-$(VERSION)-py$(PYTHON3_SHORT_VERSION).egg:
	$(MAKE) --file=../../Makefile.standard download uncompress python3build python3install
