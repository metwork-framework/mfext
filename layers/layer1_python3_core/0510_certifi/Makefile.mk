include ../../../adm/root.mk
include ../../package_python3.mk

export NAME=certifi
export VERSION=2026.7.22
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=926857e560a3ae443ee35c2de270d75b
DESCRIPTION=\
Python package for providing Mozilla s CA Bundle (patched for centos)
WEBSITE=https://certifi.io
LICENSE=MPL

all:: $(PYTHON3_SITE_PACKAGES)/$(NAME)-$(VERSION).dist-info
$(PYTHON3_SITE_PACKAGES)/$(NAME)-$(VERSION).dist-info:
	$(MAKE) --file=../../Makefile.standard download uncompress python3install_pip
