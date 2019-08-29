BINS=freeze_requirements download_compile_requirements install_requirements unsafe_pip python3_wrapper

include ../../../adm/root.mk
include ../../simple_layer.mk

all:: $(PREFIX)/bin/python3

$(PREFIX)/bin/python3:
	cd $(PREFIX)/bin && ln -s python3_wrapper python3
