include ../../../adm/root.mk
include ../../package.mk

export NAME=six
export VERSION=1.11.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=d12789f9baf7e9fb2524c0c64f1773f8
DESCRIPTION=\
Une bibliothèque de compatibilité entre Python 2 et Python 3. Requis par différents modules python.
WEBSITE=https://pypi.python.org/pypi/six/
LICENSE=MIT

all:: $(PYTHON2_SITE_PACKAGES)/$(NAME)-$(VERSION)-py$(PYTHON2_SHORT_VERSION).egg/six.py
$(PYTHON2_SITE_PACKAGES)/$(NAME)-$(VERSION)-py$(PYTHON2_SHORT_VERSION).egg/six.py:
	$(MAKE) --file=../../Makefile.standard download uncompress python2build python2install
