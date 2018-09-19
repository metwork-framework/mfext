include ../../../adm/root.mk
include ../../package.mk

export NAME=appdirs
export VERSION=1.4.3
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=44c679904082a2133f5566c8a0d3ab42
DESCRIPTION=\
WEBSITE=http://github.com/ActiveState/appdirs
LICENSE=MIT

all:: $(PYTHON2_SITE_PACKAGES)/$(NAME)-$(VERSION)-py$(PYTHON2_SHORT_VERSION).egg-info
$(PYTHON2_SITE_PACKAGES)/$(NAME)-$(VERSION)-py$(PYTHON2_SHORT_VERSION).egg-info:
	$(MAKE) --file=../../Makefile.standard download uncompress
	$(MAKE) --file=../../Makefile.standard python2build python2install
