include ../../../adm/root.mk
include $(MFEXT_HOME)/share/simple_layer.mk

export NAME=cargo-c
export VERSION=30.10.4+cargo-0.82.0.3.2

ifeq ($(PROXY_SET),0)
    unexport http_proxy
    unexport https_proxy
    unexport HTTP_PROXY
    unexport HTTPS_PROXY
endif

all:: $(PREFIX)/share/.cargo

$(PREFIX)/share/.cargo:
	rm -rf ~/.cargo
	cargo install cargo-c@0.10.4+cargo-0.82.0 --locked
	mkdir -p $(PREFIX)/share
	mv ~/.cargo $(PREFIX)/share
