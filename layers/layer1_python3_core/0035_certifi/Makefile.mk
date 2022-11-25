include ../../../adm/root.mk
include ../../package_python3.mk

export NAME=certifi
export VERSION=2022.9.24
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=ff9c8d5c7e7fb083de6b874609c5ca68
DESCRIPTION=\
Python package for providing Mozilla s CA Bundle (patched for centos)
WEBSITE=https://certifi.io
LICENSE=MPL

all:: $(PYTHON3_SITE_PACKAGES)/$(NAME)
$(PYTHON3_SITE_PACKAGES)/$(NAME):
	$(MAKE) --file=../../Makefile.standard download uncompress python3build python3install_pip
