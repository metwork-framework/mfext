-include adm/root.mk
-include adm/main_root.mk

all::
	cd adm && $(MAKE)
	cd config && $(MAKE)
	cd layers && $(MAKE) helpers
	cd pcre && $(MAKE)
	cd glib2 && $(MAKE)
	cd layerapi2 && $(MAKE)
	cd wrappers && $(MAKE)
	cd layers && $(MAKE)
	cd adm2 && $(MAKE)

clean::
	cd config && $(MAKE) clean
	cd adm && $(MAKE) clean
	cd layers && $(MAKE) clean
	cd layerapi2 && $(MAKE) clean
	cd wrappers && $(MAKE) clean
	cd adm2 && $(MAKE) clean
	cd glib2 && $(MAKE) clean
	cd pcre && $(MAKE) clean

test::
	cd adm && $(MAKE) test
	cd adm2 && $(MAKE) test
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
