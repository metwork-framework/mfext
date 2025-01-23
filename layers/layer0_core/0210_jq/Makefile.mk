include ../../../adm/root.mk
include ../../package.mk

export NAME=jq
export VERSION=1.7.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=974a340105ecb43add8c55601525f9fc
DESCRIPTION=\
jq is like sed for JSON data
WEBSITE=https://stedolan.github.io/jq/
LICENSE=MIT

all:: $(PREFIX)/bin/jq
$(PREFIX)/bin/jq:
	$(MAKE) --file=../../Makefile.standard OPTIONS="--enable-static=no --disable-maintainer-mode" download uncompress configure build install
