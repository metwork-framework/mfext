.PHONY: all clean download_archive makefiles helpers doc layerdir

include ../adm/root.mk
include ../adm/subdir_root.mk


SUBDIRS=$(shell ls -d layer* |grep -v "\.mk")

all:: layerdir makefiles helpers
	@for SUBDIR in $(SUBDIRS); do OLDPWD=`pwd`; cd $$SUBDIR || exit 1; $(MAKE) all || exit 1; cd $${OLDPWD}; done

clean:: $(MFEXT_HOME)/share/core_layer.mk python2_layer.mk python3_layer.mk
	@for SUBDIR in $(SUBDIRS); do OLDPWD=`pwd`; cd $$SUBDIR || exit 1; $(MAKE) clean || exit 1; cd $${OLDPWD}; done
	rm -f python2_layer.mk python3_layer.mk

doc:
	@for SUBDIR in $(SUBDIRS); do OLDPWD=`pwd`; cd $$SUBDIR || exit 1; $(MAKE) doc || exit 1; cd $${OLDPWD}; done

download_archive:
	rm -Rf download_archive ; mkdir download_archive
	@for SUBDIR in $(SUBDIRS); do OLDPWD=`pwd`; cd $$SUBDIR || exit 1; $(MAKE) download_archive || exit 1; cd $${OLDPWD}; done

makefiles: python2_layer.mk python3_layer.mk $(MFEXT_HOME)/share/python3_layer.mk $(MFEXT_HOME)/share/python2_layer.mk $(MFEXT_HOME)/share/package.mk $(MFEXT_HOME)/share/layer.mk $(MFEXT_HOME)/share/Makefile.standard $(MFEXT_HOME)/share/core_layer.mk $(MFEXT_HOME)/share/simple_layer.mk $(MFEXT_HOME)/share/layer_wrapper.mk $(MFEXT_HOME)/share/package_python3.mk

helpers: $(MFEXT_HOME)/bin/_uncompress_helper.sh $(MFEXT_HOME)/bin/_download_helper.sh $(MFEXT_HOME)/bin/_checksum_helper.sh $(MFEXT_HOME)/bin/_pip_package_to_yaml.sh

python2_layer.mk: python_layer.mk
	cat python_layer.mk |sed 's/PYTHONMAJORVERSION/2/g' >python2_layer.mk

python3_layer.mk: python_layer.mk
	cat python_layer.mk |sed 's/PYTHONMAJORVERSION/3/g' >python3_layer.mk

$(MFEXT_HOME)/share/python3_layer.mk: python3_layer.mk
	cp -f $< $@

$(MFEXT_HOME)/share/python2_layer.mk: python2_layer.mk
	cp -f $< $@

layerdir:
	@if ! test -d $(MFEXT_HOME)/opt; then mkdir $(MFEXT_HOME)/opt; fi
