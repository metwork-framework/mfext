.PHONY: coverage leak check clean all

LIBS=liblayerapi2.so
INCLUDES=layerapi2.h
_BINS=layers test_layerapi2 layer_load_bash_cmds layer_unload_bash_cmds is_layer_loaded is_layer_installed layer_wrapper
BINS=$(_BINS) bootstrap_layer.sh
VALGRIND=./valgrind.sh
ifeq ($(COVERAGE),yes)
    COVERAGE_CFLAGS=-fprofile-arcs -ftest-coverage
endif


include ../adm/root.mk
include $(MFEXT_HOME)/share/subdir_root.mk

_LIBS=-L. $(shell PKG_CONFIG_PATH=$(PKG_CONFIG_PATH) pkg-config --libs glib-2.0 gobject-2.0 gthread-2.0) -Wl,-rpath=$(MFEXT_HOME)/lib
_INCLUDES=-L. $(shell PKG_CONFIG_PATH=$(PKG_CONFIG_PATH) pkg-config --cflags glib-2.0 gobject-2.0 gthread-2.0)
CC=gcc
DEBUG=yes
ifeq ($(DEBUG),yes)
    DEBUG_CFLAGS=-g
else
    DEBUG_CFLAGS=-O2 -Os
endif
CFLAGS=-std=c99 -Wall -Wextra -pedantic -Werror -Wshadow -Wstrict-overflow -fno-strict-aliasing -fPIC -DG_LOG_DOMAIN=\"layerapi2\" $(DEBUG_CFLAGS) $(COVERAGE_CFLAGS)

OBJECTS=util.o log.o layer.o layerapi2.o wrapper.o

all:: $(BINS) $(LIBS) $(INCLUDES) $(MFEXT_HOME)/lib/pkgconfig/layerapi2.pc

$(MFEXT_HOME)/lib/pkgconfig/layerapi2.pc: layerapi2.pc.template
	if ! test -d $(MFEXT_HOME)/lib/pkgconfig/; then mkdir -p $(MFEXT_HOME)/lib/pkgconfig; fi
	echo $(MFEXT_HOME)
	cat $< |sed s@{{MFEXT_HOME}}@$(MFEXT_HOME)@g >$@

clean::
	rm -f $(OBJECTS) $(_BINS) $(LIBS)
	rm -Rf coverage core.*
	rm -f app.info *.gcno *.gcda

layer.o: layer.c layer.h
	$(CC) -c $(CFLAGS) $(_INCLUDES) $<

wrapper.o: wrapper.c wrapper.h
	$(CC) -c $(CFLAGS) $(_INCLUDES) $<

layerapi2.o: layerapi2.c layerapi2.h
	$(CC) -c $(CFLAGS) $(_INCLUDES) $<

util.o: util.c util.h
	$(CC) -c $(CFLAGS) $(_INCLUDES) $<

log.o: log.c log.h
	$(CC) -c $(CFLAGS) $(_INCLUDES) $<

liblayerapi2.so: $(OBJECTS)
	$(CC) -shared $(CFLAGS) $(_INCLUDES) $(_LIBS) -o $@ $^

layers: layers.c $(OBJECTS)
	$(CC) -o $@ $(CFLAGS) $(_INCLUDES) $(_LIBS) $^

is_layer_loaded: is_layer_loaded.c $(OBJECTS)
	$(CC) -o $@ $(CFLAGS) $(_INCLUDES) $(_LIBS) $^

is_layer_installed: is_layer_installed.c $(OBJECTS)
	$(CC) -o $@ $(CFLAGS) $(_INCLUDES) $(_LIBS) $^

layer_wrapper: layer_wrapper.c $(OBJECTS)
	$(CC) -o $@ $(CFLAGS) $(_INCLUDES) $(_LIBS) $^

layer_load_bash_cmds: layer_load_bash_cmds.c $(OBJECTS)
	$(CC) -o $@ $(CFLAGS) $(_INCLUDES) $(_LIBS) $^

layer_unload_bash_cmds: layer_unload_bash_cmds.c $(OBJECTS)
	$(CC) -o $@ $(CFLAGS) $(_INCLUDES) $(_LIBS) $^

test_layerapi2: test_layerapi2.c $(OBJECTS)
	$(CC) -o $@ $(CFLAGS) $(_INCLUDES) $(_LIBS) $^

check: test_layerapi2
	./test_layerapi2 && echo "OK"

leak: test_layerapi2
	$(VALGRIND) ./test_layerapi2 && echo "OK"

coverage:
	$(MAKE) clean
	$(MAKE) COVERAGE=yes test_layerapi2
	rm -Rf coverage/* app*.info && lcov --directory . --zerocounters
	./test_layerapi2
	lcov --directory . --capture --output-file app.info
	if ! test -d coverage; then mkdir coverage; fi; genhtml --output-directory coverage app.info
