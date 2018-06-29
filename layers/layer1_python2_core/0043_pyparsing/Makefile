include ../../../adm/root.mk
include ../../package.mk

export NAME=pyparsing
export VERSION=2.2.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=0214e42d63af850256962b6744c948d9
DESCRIPTION=\
A Python Parsing Module
WEBSITE=http://pyparsing.wikispaces.com/
LICENSE=MIT

all:: $(PYTHON2_SITE_PACKAGES)/$(NAME)-$(VERSION)-py$(PYTHON2_SHORT_VERSION).egg-info
$(PYTHON2_SITE_PACKAGES)/$(NAME)-$(VERSION)-py$(PYTHON2_SHORT_VERSION).egg-info:
	$(MAKE) --file=../../Makefile.standard EXPLICIT_NAME=$(NAME)-$(VERSION) download uncompress
	$(MAKE) --file=../../Makefile.standard EXPLICIT_NAME=$(NAME)-$(VERSION) python2build python2install
