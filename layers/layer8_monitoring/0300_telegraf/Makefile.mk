include ../../../adm/root.mk
include ../../package.mk

export NAME=telegraf
export VERSION=1.10.2-1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=b1481fa22064e6c07107eaeb2ecf07f7
export ARCHIVE=telegraf-1.10.2_linux_amd64.tar.gz
DESCRIPTION=\
influxdb plugin-driven server agent for collecting and reporting metrics.
WEBSITE=https://github.com/influxdata/telegraf
LICENSE=MIT

all:: $(PREFIX)/bin/telegraf
$(PREFIX)/bin/telegraf:
	@mkdir -p $(PREFIX)/bin
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	cd build/$(NAME) && cp -f usr/bin/telegraf $@
