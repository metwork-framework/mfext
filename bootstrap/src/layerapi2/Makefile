include ../../../adm/root.mk
include ../bootstrap.mk

all:
	_download_helper.sh build/layerapi2.tar.gz sources MD5 70e934833a4c1bb5b9857541697e9df4
	cd build && _uncompress_helper.sh layerapi2.tar.gz tar.gz
	cd build/layerapi2-0.0.2/src && make PREFIX=$(PREFIX) FORCE_RPATH="'"'$$$$ORIGIN/../lib'"'" && cp -f layers layer_load_bash_cmds layer_unload_bash_cmds is_layer_loaded is_layer_installed layer_wrapper get_layer_home $(PREFIX)/bin/ && cp -f liblayerapi2.so $(PREFIX)/lib/

clean:
	rm -Rf build
