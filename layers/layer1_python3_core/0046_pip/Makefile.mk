include ../../../adm/root.mk
include ../../package.mk

#Note : there is a problem when building python3_devtools with version 19.x (https://github.com/pypa/pip/issues/6222)
export NAME=pip
export VERSION=18.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=75cad449ad62c88b22de317a26781714
DESCRIPTION=\
The PyPA recommended tool for installing Python packages.
WEBSITE=https://pip.pypa.io/
LICENSE=MIT

all:: $(PREFIX)/bin/pip
$(PREFIX)/bin/pip:
	$(MAKE) --file=../../Makefile.standard download uncompress python3build python3install
	echo $@
