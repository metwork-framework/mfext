include ../../../adm/root.mk
include ../../package.mk

export NAME=filebeat
export VERSION=6.5.3
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=9268e15ae9738e2f8d8edf4958809233
export ARCHIVE=$(NAME)-$(VERSION)-linux-x86_64.$(EXTENSION)
DESCRIPTION=\
Lightweight Shipper for Logs.
WEBSITE=https://www.elastic.co/products/beats/filebeat
LICENSE=Apache

all:: $(PREFIX)/opt/filebeat/filebeat
$(PREFIX)/opt/filebeat/filebeat:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	rm -Rf $(PREFIX)/opt/filebeat
	mkdir -p $(PREFIX)/opt/filebeat
	cd build/$(NAME)-$(VERSION)-linux-x86_64 && cp -Rf * $(PREFIX)/opt/filebeat/
