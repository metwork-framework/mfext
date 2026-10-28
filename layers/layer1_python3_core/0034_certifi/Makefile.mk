include ../../../adm/root.mk
include ../../package_python3.mk

export NAME=certifi
export VERSION=2026.10.23
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=9380cf82be7f2a74885ca68665b4b12b
DESCRIPTION=\
Python package for providing Mozilla s CA Bundle (patched for centos)
WEBSITE=https://certifi.io
LICENSE=MPL

all:: $(PYTHON3_SITE_PACKAGES)/$(NAME)
$(PYTHON3_SITE_PACKAGES)/$(NAME):
	$(MAKE) --file=../../Makefile.standard download uncompress python3build python3install_pip
