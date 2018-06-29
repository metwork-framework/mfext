include ../../../adm/root.mk
include ../../package.mk

export NAME=liquidprompt
export VERSION=thefab20141015
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=afca74f3f692b8bb8ec045242dbfb9db
DESCRIPTION=\
LIQUIDPROMPT est un prompt shell adaptatif
WEBSITE=https://github.com/nojhan/liquidprompt
LICENSE=AGPL

all:: $(PREFIX)/share/liquidprompt/liquidprompt
$(PREFIX)/share/liquidprompt/liquidprompt:
	$(MAKE) --file=../../Makefile.standard download uncompress
	rm -Rf $(PREFIX)/share/liquidprompt
	mkdir -p $(PREFIX)/share/liquidprompt
	cd build/$(NAME)-$(VERSION) && cp -Rf * $(PREFIX)/share/liquidprompt/
