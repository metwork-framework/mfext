include ../../../adm/root.mk
include ../../package.mk

export NAME=nginx-upload-module
export VERSION=2.3.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=e6c59ca5f7b3aeacdc249d9a4ddba666
DESCRIPTION=\
A module for nginx for handling file uploads using multipart/form-data encoding (RFC 1867) and resumable uploads
WEBSITE=https://www.nginx.com/nginx-wiki/build/dirhtml/modules/upload/
LICENSE=BSD

all:: $(LAYER_DIR)/$(NAME)/build/$(NAME)-$(VERSION)/ngx_http_upload_module.c
$(LAYER_DIR)/$(NAME)/build/$(NAME)-$(VERSION)/ngx_http_upload_module.c: Makefile sources Makefile.mk
	$(MAKE) --file=../../Makefile.standard download uncompress
