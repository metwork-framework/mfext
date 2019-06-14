include ../../../adm/root.mk
include ../../package.mk

#Note : keep version < 10
#If not, pip try to install build dependencies found in pyproject.toml but some
#projects have flit as build dependency and flit does not exist in python2
export NAME=pip
export VERSION=9.0.3
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=b15b33f9aad61f88d0f8c866d16c55d8
DESCRIPTION=\
The PyPA recommended tool for installing Python packages.
WEBSITE=https://pip.pypa.io/
LICENSE=MIT

all:: $(PREFIX)/bin/pip
$(PREFIX)/bin/pip:
	$(MAKE) --file=../../Makefile.standard download uncompress python2build python2install
