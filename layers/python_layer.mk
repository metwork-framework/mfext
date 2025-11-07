include $(MFEXT_HOME)/share/core_layer.mk

ifeq ($(PROXY_SET),0)
	unexport http_proxy
	unexport https_proxy
	unexport HTTP_PROXY
	unexport HTTPS_PROXY
endif

LAYER_SITE_PACKAGES=$(LAYER_HOME)/lib/python$(PYTHONPYTHONMAJORVERSION_SHORT_VERSION)/site-packages
LAYER_SITE_REQUIREMENTS=$(LAYER_SITE_PACKAGES)/requirementsPYTHONMAJORVERSION.txt

all:: before $(LAYER_SITE_REQUIREMENTS) after

before::

after::

requirementsPYTHONMAJORVERSION.txt: requirements-to-freeze.txt
	if test -s $<; then freeze_requirements $< >$@; else touch $@; fi

$(LAYER_SITE_REQUIREMENTS): requirementsPYTHONMAJORVERSION.txt src
	mkdir -p $(PREFIX)/share/metwork_packages
	for REQ in requirementsPYTHONMAJORVERSION.txt; do if test -s $${REQ}; then install_requirements $(LAYER_HOME) $${REQ} ./src || { echo "ERROR WITH install_requirements $${REQ} $(LAYER_HOME) $${REQ} ./src"; exit 1; }; fi; done
	if ! test -d $(LAYER_SITE_PACKAGES); then mkdir -p $(LAYER_SITE_PACKAGES); fi
	if test -f $@; then cat $@ requirementsPYTHONMAJORVERSION.txt |sort |uniq |sed 's/^-e git.*egg=\(.*\)$$/\1/g' >$@.tmp; mv $@.tmp $@; else cat requirementsPYTHONMAJORVERSION.txt |sort |uniq |sed 's/^-e git.*egg=\(.*\)$$/\1/g' >$@ ;fi
	IFS=$$'\n' ; for REQ in `cat requirementsPYTHONMAJORVERSION.txt |sort |uniq| grep -v "\["`; do _pip_package_to_yaml.sh "$${REQ}" "$(PREFIX)/share/metwork_packages" || { echo "ERROR WITH _pip_package_to_yaml.sh $${REQ} $(PREFIX)/share/metwork_packages"; exit 1; } done

clean::
	rm -Rf src venv.* tmp_src tempolayer* requirementsPYTHONMAJORVERSION.txt.tmp freezed_requirements.*

download:: clean src

src: requirementsPYTHONMAJORVERSION.txt
	for REQ in $^; do if test -s $${REQ}; then download_compile_requirements $${REQ} || { echo "ERROR WITH download_compile_requirements $${REQ}"; exit 1; }; fi; done
	if test -d ../../download_archive; then cp -Rf src/* ../../download_archive/ 2>/dev/null; fi

freeze: superclean requirementsPYTHONMAJORVERSION.txt

superclean: clean
	rm -f requirementsPYTHONMAJORVERSION.txt

mrproper: superclean
	rm -Rf $(LAYER_HOME)
