include ../../../adm/root.mk
include ../../package.mk

export NAME=telegraf
export VERSION=1.36.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=1833ec7ed8d696b04d0bbc3a5211593b
export ARCHIVE=telegraf-$(VERSION)_linux_amd64.tar.gz
DESCRIPTION=\
influxdb plugin-driven server agent for collecting and reporting metrics.
WEBSITE=https://github.com/influxdata/telegraf
LICENSE=MIT

all:: $(PREFIX)/bin/telegraf
$(PREFIX)/bin/telegraf:
	@mkdir -p $(PREFIX)/bin
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	cd build/$(NAME)-$(VERSION) && cp -f usr/bin/telegraf $@
