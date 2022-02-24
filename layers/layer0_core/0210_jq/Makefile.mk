include ../../../adm/root.mk
include ../../package.mk

export NAME=jq
export VERSION=1.6
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=e68fbd6a992e36f1ac48c99bbf825d6b
DESCRIPTION=\
jq is like sed for JSON data
WEBSITE=https://stedolan.github.io/jq/
LICENSE=MIT

all:: $(PREFIX)/bin/jq
$(PREFIX)/bin/jq:
	$(MAKE) --file=../../Makefile.standard OPTIONS="--enable-static=no --disable-maintainer-mode" download uncompress configure build install
