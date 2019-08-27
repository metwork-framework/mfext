include ../../../adm/root.mk
include ../../package.mk

export NAME=tk
export VERSION=8.6.9.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=9efe3976468352dc894dae0c4e785a8e
DESCRIPTION=\
Tk is a graphical user interface toolkit that takes developing desktop \
applications to a higher level than conventional approaches.
WEBSITE=https://www.tcl.tk/
LICENSE=Open Source (https://www.tcl.tk/software/tcltk/license.html)

EXPLICIT_NAME=$(NAME)8.6.9

all:: $(PREFIX)/lib/libtk8.6.so
$(PREFIX)/lib/libtk8.6.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME="$(EXPLICIT_NAME)" download uncompress
	cd build/$(EXPLICIT_NAME)/unix && ./configure --prefix=$(PREFIX) && make && make install
