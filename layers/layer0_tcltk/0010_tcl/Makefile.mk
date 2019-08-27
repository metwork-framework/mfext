include ../../../adm/root.mk
include ../../package.mk

export NAME=tcl
export VERSION=8.6.9
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=27235aa437be2fa5ccedea7a66b2fee8
DESCRIPTION=\
TCL (Tool Command Language) is a very powerful but easy to learn dynamic \
programming language, suitable for a very wide range of uses, including \
web and desktop applications, networking, administration, testing and many \
more
WEBSITE=https://www.tcl.tk/
LICENSE=Open Source (https://www.tcl.tk/software/tcltk/license.html)

EXPLICIT_NAME=$(NAME)$(VERSION)

#We only build tcl "core". It is possible to build also packages itcl,
#sqlite, tdbc, tdbcmysql, tdbcodbc, tdbcpostgres and thread using
#tcl tar.gz instead of tcl-core tar.gz (see sources file)
all:: $(PREFIX)/lib/libtcl8.6.so
$(PREFIX)/lib/libtcl8.6.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME="$(EXPLICIT_NAME)" download uncompress
	cd build/$(EXPLICIT_NAME)/unix && ./configure --prefix=$(PREFIX) && make && make install
