include ../../../adm/root.mk
include ../../package.mk

export NAME=esmf
export VERSION=7_0_2
#This version is not compatible with python3
#7_1_0r may be compatible, but needs gfortran >= 4.5, not available on CentOS6
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=d2cb6e775833befc65ec9d623b18508f
DESCRIPTION=\
Earth System Modeling Framework (ESMF) Python Interface (ESMPy)
WEBSITE=http://www.earthsystemmodeling.org
LICENSE=University of Illinois NCSA Open Source License (https://opensource.org/licenses/NCSA)
export EXPLICIT_NAME=$(NAME)

export ESMF_DIR=$(CURDIR)/build/$(EXPLICIT_NAME)
export ESMF_INSTALL_PREFIX=$(PREFIX)/../scientific/$(NAME)
export ESMF_INSTALL_HEADERDIR=$(ESMF_INSTALL_PREFIX)/include
export ESMF_INSTALL_MODDIR=$(ESMF_INSTALL_PREFIX)/mod
export ESMF_INSTALL_LIBDIR=$(ESMF_INSTALL_PREFIX)/lib
export ESMF_INSTALL_BINDIR=$(ESMF_INSTALL_PREFIX)/bin
export ESMF_INSTALL_DOCDIR=$(ESMF_INSTALL_PREFIX)/doc
export ESMF_NETCDF=split
export ESMF_NETCDF_INCLUDE=$(PREFIX)/../scientific_core/include
export ESMF_NETCDF_LIBPATH=$(PREFIX)/../scientific_core/lib


all::
#all:: $(PREFIX)/lib/python$(PYTHON3_SHORT_VERSION)/site-packages/ESMPy-700-py$(PYTHON3_SHORT_VERSION).egg-info
#$(PREFIX)/lib/python$(PYTHON3_SHORT_VERSION)/site-packages/ESMPy-700-py$(PYTHON3_SHORT_VERSION).egg-info:
#	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX)                     EXPLICIT_NAME="$(EXPLICIT_NAME)" download uncompress
#	cd build/$(EXPLICIT_NAME)/src/addon/ESMPy && python setup.py build --ESMFMKFILE=$(ESMF_INSTALL_LIBDIR)/esmf.mk && python setup.py install --prefix=$(PREFIX)
