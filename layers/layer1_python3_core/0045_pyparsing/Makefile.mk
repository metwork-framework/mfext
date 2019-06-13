include ../../../adm/root.mk
include ../../package.mk

export NAME=pyparsing
export VERSION=2.4.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=e534c0ca755155823bf45fdd8d084922
DESCRIPTION=\
A Python Parsing Module
WEBSITE=http://pyparsing.wikispaces.com/
LICENSE=MIT

all:: $(PYTHON3_SITE_PACKAGES)/$(NAME)-$(VERSION)-py$(PYTHON3_SHORT_VERSION).egg
$(PYTHON3_SITE_PACKAGES)/$(NAME)-$(VERSION)-py$(PYTHON3_SHORT_VERSION).egg:
	$(MAKE) --file=../../Makefile.standard download uncompress
	$(MAKE) --file=../../Makefile.standard python3build python3install
