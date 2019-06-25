include ../../../adm/root.mk
include ../../package.mk

export NAME=virtualenv
export VERSION=16.6.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=55b8d77a83d0141abaee55542d5941e9
DESCRIPTION=\
Virtual Python Environment builder
WEBSITE=https://virtualenv.pypa.io/
LICENSE=MIT

all:: $(PREFIX)/bin/virtualenv
$(PREFIX)/bin/virtualenv:
	$(MAKE) --file=$(SRC_DIR)/layers/Makefile.standard download uncompress python2build python2install
