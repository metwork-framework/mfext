include ../../../adm/root.mk
include $(SRC_DIR)/layers/package.mk

export NAME=shellcheck
export VERSION=0.9.0
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=206ca97e055fccfe3546369d14a37760
export EXPLICIT_NAME=$(NAME)-v$(VERSION)
DESCRIPTION=\
ShellCheck is a bash linter
WEBSITE=http://www.shellcheck.net
LICENSE=GPL

all:: $(PREFIX)/bin/shellcheck
$(PREFIX)/bin/shellcheck:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME="$(EXPLICIT_NAME)" download uncompress
	mkdir -p $(PREFIX)/bin
	cp -f build/$(EXPLICIT_NAME)/shellcheck $(PREFIX)/bin/shellcheck
	chmod a+rx $(PREFIX)/bin/shellcheck
