include ../../../adm/root.mk
include ../../package.mk

export NAME=ConfigUpdater
export VERSION=1.0.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=6fb0e4371b22d9bb72efa79181000aac
DESCRIPTION=\
Parser like ConfigParser but for updating configuration files
WEBSITE=https://github.com/pyscaffold/configupdater
LICENSE=MIT

all:: $(PYTHON3_SITE_PACKAGES)/configupdater/configupdater.py
$(PYTHON3_SITE_PACKAGES)/configupdater/configupdater.py:
	$(MAKE) --file=../../Makefile.standard download uncompress python3build python3install_pip
