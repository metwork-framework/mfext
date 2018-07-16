include $(MFEXT_HOME)/share/core_layer.mk

unexport http_proxy
unexport https_proxy
unexport HTTP_PROXY
unexport HTTPS_PROXY

LAYER_SITE_PACKAGES=$(LAYER_HOME)/lib/python$(PYTHONPYTHONMAJORVERSION_SHORT_VERSION)/site-packages
LAYER_SITE_REQUIREMENTS=$(LAYER_SITE_PACKAGES)/requirementsPYTHONMAJORVERSION.txt

all:: before $(LAYER_SITE_REQUIREMENTS) after

before::

after::

requirementsPYTHONMAJORVERSION.txt: requirements-to-freeze.txt
	if test -s $<; then freeze_requirements $< >$@; else touch $@; fi

prerequirementsPYTHONMAJORVERSION.txt: prerequirements-to-freeze.txt
	if test -s $<; then freeze_requirements $< >$@; else touch $@; fi

$(LAYER_SITE_REQUIREMENTS): prerequirementsPYTHONMAJORVERSION.txt requirementsPYTHONMAJORVERSION.txt src
	mkdir -p $(PREFIX)/share/metwork_packages
	for REQ in prerequirementsPYTHONMAJORVERSION.txt requirementsPYTHONMAJORVERSION.txt; do if test -s $${REQ}; then install_requirements $(LAYER_HOME) $${REQ} ./src; fi; done
	if ! test -d $(LAYER_SITE_PACKAGES); then mkdir -p $(LAYER_SITE_PACKAGES); fi
	cat prerequirementsPYTHONMAJORVERSION.txt requirementsPYTHONMAJORVERSION.txt |sort |uniq |sed 's/^-e git.*egg=\(.*\)$$/\1/g' >$@
	IFS=$$'\n' ; for REQ in `cat prerequirementsPYTHONMAJORVERSION.txt requirementsPYTHONMAJORVERSION.txt |sort |uniq`; do _pip_package_to_yaml.sh "$${REQ}" "$(PREFIX)/share/metwork_packages" || { echo "ERROR WITH _pip_package_to_yaml.sh $${REQ} $(PREFIX)/share/metwork_packages"; exit 1; } done

clean::
	rm -Rf src venv.* tmp_src tempolayer* requirementsPYTHONMAJORVERSION.txt.tmp prerequirementsPYTHONMAJORVERSION.txt.tmp freezed_requirements.*

download:: clean src

src: prerequirementsPYTHONMAJORVERSION.txt requirementsPYTHONMAJORVERSION.txt
	for REQ in $^; do if test -s $${REQ}; then download_compile_requirements $${REQ}; fi; done
	if test -d ../../download_archive; then cp -Rf src/* ../../download_archive/ 2>/dev/null; fi

freeze: superclean prerequirementsPYTHONMAJORVERSION.txt requirementsPYTHONMAJORVERSION.txt

superclean: clean
	rm -f requirementsPYTHONMAJORVERSION.txt
	rm -f prerequirementsPYTHONMAJORVERSION.txt

mrproper: superclean
	rm -Rf $(LAYER_HOME)
