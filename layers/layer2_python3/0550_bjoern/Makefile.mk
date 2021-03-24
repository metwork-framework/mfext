include ../../../adm/root.mk
include ../../package.mk

ifeq ($(PROXY_SET),0)
        unexport http_proxy
        unexport https_proxy
        unexport HTTP_PROXY
        unexport HTTPS_PROXY
endif

export NAME=bjoern
export VERSION=metwork-20190515
export EXTENSION=zip
export CHECKTYPE=MD5
export CHECKSUM=0ecf48ca01016ba33eb0ca0e4f15d9ef
DESCRIPTION=\
Fast And Ultra-Lightweight HTTP/1.1 WSGI Server
WEBSITE=https://github.com/thefab/bjoern/tree/metwork
LICENSE=BSD

export EXPLICIT_NAME=bjoern-metwork

all:: $(PYTHON3_SITE_PACKAGES)/bjoern.py
$(PYTHON3_SITE_PACKAGES)/bjoern.py:
	$(MAKE) --file=../../Makefile.standard EXPLICIT_NAME=$(EXPLICIT_NAME) download uncompress
	wget -O build/bjoern-metwork/http-parser/http_parser.c "https://raw.githubusercontent.com/nodejs/http-parser/1786fdae36d3d40d59463dacab1cfb4165cf9f1d/http_parser.c"
	wget -O build/bjoern-metwork/http-parser/http_parser.h "https://raw.githubusercontent.com/nodejs/http-parser/1786fdae36d3d40d59463dacab1cfb4165cf9f1d/http_parser.h"
	$(MAKE) --file=../../Makefile.standard EXPLICIT_NAME=$(EXPLICIT_NAME) EXTRACFLAGS="-I$(PREFIX)/../core/include" EXTRALDFLAGS="-L$(PREFIX)/../core/lib" python3build  python3install_pip
