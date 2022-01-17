include ../../../adm/root.mk
include ../../package.mk

export NAME=certifi
export VERSION=2021.10.8
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=880ed9e5d04aff8f46f5ff82a3a3e395
DESCRIPTION=\
Python package for providing Mozilla s CA Bundle (patched for centos)
WEBSITE=https://certifi.io
LICENSE=MPL

all:: $(PYTHON3_SITE_PACKAGES)/$(NAME)
$(PYTHON3_SITE_PACKAGES)/$(NAME):
	$(MAKE) --file=../../Makefile.standard download uncompress python3build python3install_pip
