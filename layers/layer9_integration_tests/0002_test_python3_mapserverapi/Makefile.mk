include ../../../adm/root.mk
include ../../package.mk

export NAME=test_python3_mapserverapi

all:: $(PREFIX)/$(NAME)/$(NAME).sh
$(PREFIX)/$(NAME)/$(NAME).sh:
	mkdir -p $(PREFIX)/$(NAME)
	cp .layerapi2_* $(PREFIX)/$(NAME)
	cp test* $(PREFIX)/$(NAME)
	cp -r ../test_datas_mapserverapi $(PREFIX)/$(NAME)/test_datas
