include ../../../adm/root.mk
include ../../package.mk

export NAME=ack
export VERSION=2.16-single-file
export EXTENSION=
export CHECKTYPE=MD5
export CHECKSUM=7085b5a5c76fda43ff049410870c8535
DESCRIPTION=\
ACK is a tool like grep, optimized for programmers
WEBSITE=https://beyondgrep.com/
LICENSE=Artistic

all:: $(PREFIX)/bin/ack
$(PREFIX)/bin/ack:
	$(MAKE) --file=../../Makefile.standard download
	cd build && cp -f $(NAME)-$(VERSION) $(PREFIX)/bin/ack
	chmod ug+rx $(PREFIX)/bin/ack
