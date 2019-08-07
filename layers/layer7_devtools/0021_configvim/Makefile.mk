include ../../../adm/root.mk
include ../../simple_layer.mk

all:: $(PREFIX)/config/vim/autoload/pathogen.vim
$(PREFIX)/config/vim/autoload/pathogen.vim: Makefile vimrc Makefile.mk
	mkdir -p $(PREFIX)/config
	mkdir -p $(PREFIX)/bin
	rm -Rf $(PREFIX)/config/vim
	cp -Rf vim $(PREFIX)/config/
	cp -f vimrc $(PREFIX)/config/
