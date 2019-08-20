include ../adm/root.mk
include ../adm/subdir_root.mk

export NAME=libffi
export VERSION=3.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=41e0216cc2be4029fad3128988295f0f
DESCRIPTION=\
A Portable Foreign Function Interface Library
WEBSITE=https://sourceware.org/libffi/
LICENSE=BSD

all:: $(MFEXT_HOME)/lib/libffi.so
$(MFEXT_HOME)/lib/libffi.so: Makefile sources
	@$(MAKE) -s before
	@$(MAKE) -s cache$(MFEXT_HOME)/lib/libffi.so
	cd cache$(MFEXT_HOME) && cp -Rf * $(MFEXT_HOME)/
	@$(MAKE) -s after

cache$(MFEXT_HOME)/lib/libffi.so:
	$(MAKE) --file=../layers/Makefile.standard MAKEOPT="DESTDIR=$(shell pwd)/cache" PREFIX=$(MFEXT_HOME) OPTIONS="--libdir=$(MFEXT_HOME)/lib --enable-portable-binary --enable-shared --disable-static --enable-unicode-properties" download uncompress configure build install


before:
	_cache_logic_before.sh ffi . $(PREFIX) root@mfext

after:
	_cache_logic_after.sh . $(PREFIX)

clean::
	rm -Rf build
	rm -Rf cache
