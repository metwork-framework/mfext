include ../../../adm/root.mk
include ../../package.mk

export NAME=pyke
export VERSION=1.1.1
export EXTENSION=zip
export CHECKTYPE=MD5
export CHECKSUM=a7d12d66d4c2ec12576a8187d3001384
DESCRIPTION=\
PYKE integrates a form of Logic Programming into Python by providing a knowledge engine that can\
    Do both forward-chaining (data driven) and backward-chaining (goal directed) inferencing\
    Automatically generate Python programs by assembling individual Python functions into complete call graphs.
WEBSITE=https://sourceforge.net/projects/pyke/
LICENSE=MIT

all:: $(PREFIX)/lib/python$(PYTHON3_SHORT_VERSION)/site-packages/$(NAME)-$(VERSION)-py$(PYTHON3_SHORT_VERSION).egg-info
$(PREFIX)/lib/python$(PYTHON3_SHORT_VERSION)/site-packages/$(NAME)-$(VERSION)-py$(PYTHON3_SHORT_VERSION).egg-info:
	$(MAKE) --file=../../Makefile.standard download uncompress python3build python3install
