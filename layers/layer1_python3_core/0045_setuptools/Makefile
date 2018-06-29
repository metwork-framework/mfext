include ../../../adm/root.mk
include ../../package.mk

export NAME=setuptools
export VERSION=38.2.4
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=a317d98b091f6c53a905e1b7dcf7d7d1
DESCRIPTION=\
PYTHON_SETUPTOOLS est un outil pour gérer des packages Python
WEBSITE=https://pypi.python.org/pypi/setuptools
LICENSE=Python

all:: $(PREFIX)/bin/easy_install
$(PREFIX)/bin/easy_install:
	rm -Rf $(PREFIX)/lib/python$(PYTHON3_SHORT_VERSION)/site-packages/setuptools*
	rm -Rf $(PREFIX)/lib/python$(PYTHON3_SHORT_VERSION)/site-packages/pkg_resources*
	$(MAKE) --file=../../Makefile.standard EXPLICIT_NAME=setuptools-$(VERSION) download uncompress
	cd build/setuptools-$(VERSION) && $(MFEXT_HOME)/bin/python3 bootstrap.py
	$(MAKE) --file=../../Makefile.standard EXPLICIT_NAME=setuptools-$(VERSION) python3build python3install
