include ../../../adm/root.mk
include ../../package.mk

export NAME=json-c
export VERSION=0.13.1-20180305
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=20dba7bf773599a0842745a2fe5b7cd3
export EXPLICIT_NAME=$(NAME)-$(NAME)-$(VERSION)
DESCRIPTION=\
JSON-C implements a reference counting object model that allows you to easily\
construct JSON objects in C, output them as JSON formatted strings and parse\
JSON formatted strings back into the C representation of JSON objects.
WEBSITE=https://github.com/json-c/json-c
LICENSE=MIT

all:: $(PREFIX)/lib/libjson-c.so
$(PREFIX)/lib/libjson-c.so:
	$(MAKE) --file=../../Makefile.standard EXPLICIT_NAME="$(EXPLICIT_NAME)" download uncompress configure build install
