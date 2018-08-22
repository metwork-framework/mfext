include ../../../adm/root.mk
include $(SRC_DIR)/layers/package.mk

export NAME=shellcheck
export VERSION=20170801
export EXTENSION=NO
export CHECKTYPE=MD5
export CHECKSUM=2884164666a569e24af415fbf8ff91b9
DESCRIPTION=\
ShellCheck is a bash linter
WEBSITE=http://www.shellcheck.net
LICENSE=GPL

all:: $(PREFIX)/bin/shellcheck
$(PREFIX)/bin/shellcheck:
	$(MAKE) --file=$(SRC_DIR)/layers/Makefile.standard download
	mkdir -p $(PREFIX)/bin
	cp -f build/$(NAME)-$(VERSION).$(EXTENSION) $(PREFIX)/bin/shellcheck
	chmod ug+rx $(PREFIX)/bin/shellcheck
