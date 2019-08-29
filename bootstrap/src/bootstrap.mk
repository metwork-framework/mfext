PWD=$(shell pwd)
PREFIX=$(shell readlink -f $(PWD)/../..)

export PATH := $(PREFIX)/bin:$(PATH)
export LD_LIBRARY_PATH := $(PREFIX)/lib:$(LD_LIBRARY_PATH)
export PKG_CONFIG_PATH := $(PREFIX)/lib/pkgconfig:$(PKG_CONFIG_PATH)
