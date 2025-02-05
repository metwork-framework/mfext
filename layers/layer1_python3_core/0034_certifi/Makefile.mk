include ../../../adm/root.mk
include ../../package_python3.mk

export NAME=certifi
export VERSION=2025.1.31
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=6d326c5b0649c4dee817837c192f3824
DESCRIPTION=\
Python package for providing Mozilla s CA Bundle (patched for centos)
WEBSITE=https://certifi.io
LICENSE=MPL

all:: $(PYTHON3_SITE_PACKAGES)/$(NAME)
$(PYTHON3_SITE_PACKAGES)/$(NAME):
	$(MAKE) --file=../../Makefile.standard download uncompress python3build python3install_pip
