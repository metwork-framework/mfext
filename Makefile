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
	cd layers && $(MAKE) makefiles
	_layer_dhash root@mfext >$(MFEXT_HOME)/.dhash
	cd layers && $(MAKE)
	cd adm && $(MAKE) all

clean::
	cd config && $(MAKE) clean
	cd adm && $(MAKE) clean
	cd layers && $(MAKE) clean
	cd bootstrap/src && $(MAKE) clean
	rm -Rf _docs_build

test::
	cd adm && $(MAKE) test

.PHONY: docs
docs:
	cd docs && make
	rm -Rf _docs_build
	layer_wrapper --layers=python3_devtools@mfext -- mkdocs build --strict --site-dir _docs_build
	rm -Rf $(MFMODULE_HOME)/html_doc && cp -Rf _docs_build $(MFMODULE_HOME)/html_doc
