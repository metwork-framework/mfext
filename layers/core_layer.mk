ifeq ($(PROXY_SET),0)
	# To avoid python autodownload during installation
	export http_proxy=http://127.0.0.1:9999
	export https_proxy=http://127.0.0.1:9999
	export HTTP_PROXY=http://127.0.0.1:9999
	export HTTPS_PROXY=http://127.0.0.1:9999
endif

export SOURCE := $(shell pwd)
export LAYER_DIR := $(shell dirname $(SOURCE))
export LAYER_NAME := $(shell basename $(LAYER_DIR) |sed 's/^layer[0-9]_//g')
export PREFIX := $(MODULE_HOME)/opt/$(LAYER_NAME)
export LAYER_HOME := $(MODULE_HOME)/opt/$(LAYER_NAME)
export PYTHON2_SITE_PACKAGES := $(PREFIX)/lib/python$(PYTHON2_SHORT_VERSION)/site-packages
export PYTHON3_SITE_PACKAGES := $(PREFIX)/lib/python$(PYTHON3_SHORT_VERSION)/site-packages
