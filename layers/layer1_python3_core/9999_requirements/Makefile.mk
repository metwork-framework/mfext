include ../../../adm/root.mk
include ../../simple_layer.mk

all:: $(PREFIX)/lib/python$(PYTHON3_SHORT_VERSION)/site-packages/requirements3.txt

$(PREFIX)/lib/python$(PYTHON3_SHORT_VERSION)/site-packages/requirements3.txt:
	pip freeze >$@
