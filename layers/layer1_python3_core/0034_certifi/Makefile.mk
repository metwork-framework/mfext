include ../../../adm/root.mk
include ../../package_python3.mk

export NAME=certifi
<<<<<<< HEAD:layers/layer1_python3_core/0034_certifi/Makefile.mk
export VERSION=2025.4.26
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=507ac42a33a6ea8e9629f5624455c2bf
=======
export VERSION=2026.10.23
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=9380cf82be7f2a74885ca68665b4b12b
>>>>>>> ad4d8dc (feat: bump certifi from 2926.7.22 to 2026.10.23):layers/layer1_python3_core/0510_certifi/Makefile.mk
DESCRIPTION=\
Python package for providing Mozilla s CA Bundle (patched for centos)
WEBSITE=https://certifi.io
LICENSE=MPL

all:: $(PYTHON3_SITE_PACKAGES)/$(NAME)
$(PYTHON3_SITE_PACKAGES)/$(NAME):
	$(MAKE) --file=../../Makefile.standard download uncompress python3build python3install_pip
