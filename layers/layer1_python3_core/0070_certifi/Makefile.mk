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

#remove pyproject.toml when it will be included in certifi next release

all:: $(PYTHON3_SITE_PACKAGES)/$(NAME)-$(VERSION).dist-info
$(PYTHON3_SITE_PACKAGES)/$(NAME)-$(VERSION).dist-info:
	$(MAKE) --file=../../Makefile.standard download uncompress
	cp pyproject.toml build/$(NAME)-$(VERSION)
	$(MAKE) --file=../../Makefile.standard python3install_pip
