include ../../../adm/root.mk
include ../../package.mk

export NAME=pip
export VERSION=9.0.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=35f01da33009719497f01a4ba69d63c9
DESCRIPTION=\
The PyPA recommended tool for installing Python packages.
WEBSITE=https://pip.pypa.io/
LICENSE=MIT

all:: $(PREFIX)/bin/pip
$(PREFIX)/bin/pip:
	$(MAKE) --file=../../Makefile.standard EXTRACFLAGS=-I$(PREFIX)/include download uncompress python3build python3install
	echo $@
