include ../../../adm/root.mk
include ../../package.mk

export NAME=virtualenv
export VERSION=15.1.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=44e19f4134906fe2d75124427dc9b716
DESCRIPTION=\
Virtual Python Environment builder
WEBSITE=https://virtualenv.pypa.io/
LICENSE=MIT

all:: $(PREFIX)/bin/virtualenv
$(PREFIX)/bin/virtualenv:
	$(MAKE) --file=$(SRC_DIR)/layers/Makefile.standard download uncompress python3build python3install
