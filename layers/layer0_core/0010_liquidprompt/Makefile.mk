include ../../../adm/root.mk
include ../../package.mk

export NAME=liquidprompt
export VERSION=v_1.11
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=4b2562a5cc66829d18c0bffe368af8f0
export ARCHIVE=$(VERSION).$(EXTENSION)
DESCRIPTION=\
LIQUIDPROMPT is a full-featured & carefully designed adaptive prompt for Bash & Zsh
WEBSITE=https://github.com/nojhan/liquidprompt
LICENSE=AGPL

all:: $(PREFIX)/share/liquidprompt/liquidprompt
$(PREFIX)/share/liquidprompt/liquidprompt:
	$(MAKE) --file=../../Makefile.standard ARCHIVE=$(ARCHIVE) download uncompress
	rm -Rf $(PREFIX)/share/liquidprompt
	mkdir -p $(PREFIX)/share/liquidprompt
	cd build/$(NAME)-$(VERSION) && cp -Rf * $(PREFIX)/share/liquidprompt/
