include ../../../adm/root.mk
include ../../package.mk

export NAME=pyke
export VERSION=1.1.1
export EXTENSION=zip
export CHECKTYPE=MD5
export CHECKSUM=b0f9daa278d9996bc742277126831001
DESCRIPTION=\
PYKE integrates a form of Logic Programming into Python by providing a knowledge engine that can\
    Do both forward-chaining (data driven) and backward-chaining (goal directed) inferencing\
    Automatically generate Python programs by assembling individual Python functions into complete call graphs.
WEBSITE=https://sourceforge.net/projects/pyke/
LICENSE=MIT

all:: $(PREFIX)/lib/python$(PYTHON2_SHORT_VERSION)/site-packages/$(NAME)-$(VERSION)-py$(PYTHON2_SHORT_VERSION).egg-info
$(PREFIX)/lib/python$(PYTHON2_SHORT_VERSION)/site-packages/$(NAME)-$(VERSION)-py$(PYTHON2_SHORT_VERSION).egg-info:
	$(MAKE) --file=../../Makefile.standard download uncompress python2build python2install
