include ../../../adm/root.mk
include ../../package.mk

export NAME=dtreetrawl
export VERSION=master20190715
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=36088a5ac80de534a5434eb74500f537
DESCRIPTION=\
Trawl/traverse directory tree or file path to collect stats of every entry in the tree with optional hashing/checksum
WEBSITE=https://github.com/raamsri/dtreetrawl
LICENSE=Public Domain

all:: $(PREFIX)/bin/dtreetrawl
$(PREFIX)/bin/dtreetrawl: Makefile sources patches
	$(MAKE) --file=../../Makefile.standard download uncompress
	cd build/$(NAME)-$(VERSION) && make && cp -f dtreetrawl $@

clean::
	rm -Rf build
