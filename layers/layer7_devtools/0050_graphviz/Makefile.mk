include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=graphviz
export VERSION=2.40.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=4ea6fd64603536406166600bcc296fc8
DESCRIPTION=\
GRAPHVIZ is open source graph visualization software. It has several main graph\
layout programs. It also has web and interactive graphical interfaces, and\
auxiliary tools, libraries, and language bindings.
WEBSITE=https://graphviz.org
LICENSE=Common Public License Version 1.0 (https://www.graphviz.org/license/)

all:: $(PREFIX)/lib/libcgraph.so
$(PREFIX)/lib/libcgraph.so:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) OPTIONS="--disable-python --disable-guile --disable-java --disable-perl --disable-lua --disable-tcl --disable-swig --disable-sharp --disable-ocaml --disable-php --disable-r --disable-ruby" download uncompress configure build install
