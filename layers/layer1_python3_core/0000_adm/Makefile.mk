BINS=freeze_requirements download_compile_requirements install_requirements unsafe_pip python2_wrapper python3_wrapper

include ../../../adm/root.mk
include ../../simple_layer.mk

all:: $(PREFIX)/bin/python2

$(PREFIX)/bin/python2:
	cd $(PREFIX)/bin && ln -s python2_wrapper python2
