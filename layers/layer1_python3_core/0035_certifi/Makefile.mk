include ../../../adm/root.mk
include ../../package_python3.mk

export NAME=certifi
export VERSION=2022.12.7
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=d00966473b8ac42c2c033b75f4bed6f4
DESCRIPTION=\
Python package for providing Mozilla s CA Bundle (patched for centos)
WEBSITE=https://certifi.io
LICENSE=MPL

all:: $(PYTHON3_SITE_PACKAGES)/$(NAME)
$(PYTHON3_SITE_PACKAGES)/$(NAME):
	$(MAKE) --file=../../Makefile.standard download uncompress python3build python3install_pip
