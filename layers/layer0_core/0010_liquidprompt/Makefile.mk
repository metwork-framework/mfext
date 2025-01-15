include ../../../adm/root.mk
include ../../package.mk

export NAME=liquidprompt
export VERSION=2.2.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=1f84545d80a355d86dd3bcdab525ff4c
export ARCHIVE=v$(VERSION).$(EXTENSION)
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
