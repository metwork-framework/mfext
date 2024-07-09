include ../../../adm/root.mk
include ../../package_python3.mk

export NAME=certifi
export VERSION=2024.7.4
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=ecf1d20e4c505fc07c8f421063d04103
DESCRIPTION=\
Python package for providing Mozilla s CA Bundle (patched for centos)
WEBSITE=https://certifi.io
LICENSE=MPL

all:: $(PYTHON3_SITE_PACKAGES)/$(NAME)
$(PYTHON3_SITE_PACKAGES)/$(NAME):
	$(MAKE) --file=../../Makefile.standard download uncompress python3build python3install_pip
