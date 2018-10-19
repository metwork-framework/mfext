include ../../../adm/root.mk
include ../../package.mk

export NAME=test_python3_sqlite3

all:: $(PREFIX)/$(NAME)/$(NAME).sh
$(PREFIX)/$(NAME)/$(NAME).sh:
	mkdir -p $(PREFIX)/$(NAME)
	cp .layerapi2_* $(PREFIX)/$(NAME)
	cp test* $(PREFIX)/$(NAME)
