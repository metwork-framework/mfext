include ../../../adm/root.mk
include ../../simple_layer.mk

ifeq ($(shell cat /etc/redhat-release | grep -c "release 8"), 1)

LIB_LIST = $(shell cat libraries.txt)
$(shell mkdir $(PREFIX)/lib)

all:: $(PREFIX)/lib/libjson-c.so.4
$(PREFIX)/lib/libjson-c.so.4:
	for lib in $(LIB_LIST); do cp -r $$lib $(PREFIX)/lib; done
endif
