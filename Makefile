-include adm/root.mk
-include adm/main_root.mk

before::
	rm -f $(MFEXT_HOME)/.dhash_ignore_hash
	touch $(MFEXT_HOME)/.dhash_ignore_hash
	echo "bin/python2" >>$(MFEXT_HOME)/.dhash_ignore_hash
	echo "bin/python3" >>$(MFEXT_HOME)/.dhash_ignore_hash
	echo "bin/sphinx_wrapper" >>$(MFEXT_HOME)/.dhash_ignore_hash

all::
	cd adm && $(MAKE) before_layers
	cd config && $(MAKE)
	cd layers && $(MAKE) helpers
	cd pcre && $(MAKE)
	cd glib2 && $(MAKE)
	cd dtreetrawl && $(MAKE)
	cd mfutil_c && $(MAKE)
	cd layerapi2 && $(MAKE)
	cd wrappers && $(MAKE)
	cd layers && $(MAKE) makefiles
	_layer_dhash root@mfext >$(MFEXT_HOME)/.dhash
	cd layers && $(MAKE)
	cd adm && $(MAKE) all

clean::
	cd config && $(MAKE) clean
	cd adm && $(MAKE) clean
	cd layerapi2 && $(MAKE) clean
	cd wrappers && $(MAKE) clean
	cd glib2 && $(MAKE) clean
	cd dtreetrawl && $(MAKE) clean
	cd pcre && $(MAKE) clean
	cd mfutil_c && $(MAKE) clean
	cd layers && $(MAKE) clean

test::
	cd adm && $(MAKE) test
	cd layerapi2 && $(MAKE) check && $(MAKE) leak

sloccount: clean
	rm -Rf /tmp/metwork_count
	mkdir -p /tmp/metwork_count
	cp -Rf * /tmp/metwork_count
	rm -Rf /tmp/metwork_count/layers/layer7_devtools/0021_configvim/
	rm -Rf /tmp/metwork_count/layers/layer7_devtools/0000_penvtpl/
	rm -Rf /tmp/metwork_count/layers/download_archive
	layer_wrapper --layers=devtools@mfext -- sloccount /tmp/metwork_count
	rm -Rf /tmp/metwork_count
