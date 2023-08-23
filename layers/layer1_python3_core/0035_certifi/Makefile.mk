include ../../../adm/root.mk
include ../../package_python3.mk

export NAME=certifi
export VERSION=2023.7.22
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=10a72845d3fc2c38d212b4b7b1872c76
DESCRIPTION=\
Python package for providing Mozilla s CA Bundle (patched for centos)
WEBSITE=https://certifi.io
LICENSE=MPL

all:: $(PYTHON3_SITE_PACKAGES)/$(NAME)
$(PYTHON3_SITE_PACKAGES)/$(NAME):
	$(MAKE) --file=../../Makefile.standard download uncompress python3build python3install_pip
