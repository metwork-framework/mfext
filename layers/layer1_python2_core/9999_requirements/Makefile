include ../../../adm/root.mk
include ../../simple_layer.mk

all:: $(PREFIX)/lib/python$(PYTHON2_SHORT_VERSION)/site-packages/requirements3.txt

$(PREFIX)/lib/python$(PYTHON2_SHORT_VERSION)/site-packages/requirements3.txt:
	layer_wrapper --layers=python2_core@mfext -- pip freeze >$@
