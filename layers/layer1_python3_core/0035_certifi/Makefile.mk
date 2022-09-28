include ../../../adm/root.mk
include ../../package_python3.mk

export NAME=certifi
export VERSION=2022.6.15.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=10b6970c3e64d037137f4bd052ef417c
DESCRIPTION=\
Python package for providing Mozilla s CA Bundle (patched for centos)
WEBSITE=https://certifi.io
LICENSE=MPL

all:: $(PYTHON3_SITE_PACKAGES)/$(NAME)
$(PYTHON3_SITE_PACKAGES)/$(NAME):
	$(MAKE) --file=../../Makefile.standard download uncompress python3build python3install_pip
