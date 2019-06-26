include ../../../adm/root.mk
include ../../package.mk

export NAME=setuptools
export VERSION=41.0.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=5493fb91984e98102b095e0df2490560
DESCRIPTION=\
Setuptools is a package development process library designed to facilitate \
download, build, install, upgrade, and uninstall Python packages
WEBSITE=https://pypi.python.org/pypi/setuptools
LICENSE=Python

all:: $(PREFIX)/bin/easy_install
$(PREFIX)/bin/easy_install:
	rm -Rf $(PREFIX)/lib/python$(PYTHON3_SHORT_VERSION)/site-packages/setuptools*
	rm -Rf $(PREFIX)/lib/python$(PYTHON3_SHORT_VERSION)/site-packages/pkg_resources*
	$(MAKE) --file=../../Makefile.standard download uncompress
	cd build/$(NAME)-$(VERSION) && python3 bootstrap.py
	$(MAKE) --file=../../Makefile.standard python3build python3install
