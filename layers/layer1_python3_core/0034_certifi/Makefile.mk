include ../../../adm/root.mk
include ../../package_python3.mk

export NAME=certifi
export VERSION=2025.4.26
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=507ac42a33a6ea8e9629f5624455c2bf
DESCRIPTION=\
Python package for providing Mozilla s CA Bundle (patched for centos)
WEBSITE=https://certifi.io
LICENSE=MPL

all:: $(PYTHON3_SITE_PACKAGES)/$(NAME)
$(PYTHON3_SITE_PACKAGES)/$(NAME):
	$(MAKE) --file=../../Makefile.standard download uncompress python3build python3install_pip
