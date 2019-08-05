include ../adm/root.mk
include ../adm/subdir_root.mk

export NAME=dtreetrawl
export VERSION=master20190715
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=36088a5ac80de534a5434eb74500f537
DESCRIPTION=\
Trawl/traverse directory tree or file path to collect stats of every entry in the tree with optional hashing/checksum
WEBSITE=https://github.com/raamsri/dtreetrawl
LICENSE=Public Domain

all:: $(MFEXT_HOME)/bin/dtreetrawl
$(MFEXT_HOME)/bin/dtreetrawl: Makefile sources patches
	$(MAKE) --file=../layers/Makefile.standard PREFIX=$(MFEXT_HOME) download uncompress
	cd build/$(NAME)-$(VERSION) && make && cp -f dtreetrawl $@

clean::
	rm -Rf build
