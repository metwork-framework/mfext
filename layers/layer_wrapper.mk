export PATH := $(MFEXT_HOME)/bin:/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin
unexport LD_LIBRARY_PATH
unexport PKG_CONFIG_PATH
export FORCED_PATHS := yes

# hack around pwd versus $(PWD) to support some symbolic links
# see https://stackoverflow.com/questions/8390502/how-to-make-gnu-make-stop-de-referencing-symbolic-links-to-directories
_PWD=$(PWD)
_PARENT_PWD=$(shell dirname $(_PWD))

LAYERS_TO_LOAD=$(shell cat $(_PARENT_PWD)/.layerapi2_dependencies |xargs |sed 's/ /,/g')
CURRENT_LAYER=$(shell cat $(_PARENT_PWD)/.layerapi2_label)

.DEFAULT_GOAL := all

clean:
	$(MAKE) -f Makefile.mk clean

.DEFAULT:
	layer_wrapper --empty-env --empty-env-keeps=LANG,PATH,LAYERAPI2_LAYERS_PATH,PYTHON3_SHORT_VERSION,PYTHON2_SHORT_VERSION,FORCED_PATHS,BUILDCACHE --force-prepend --layers=$(LAYERS_TO_LOAD),$(CURRENT_LAYER) -- make -f Makefile.mk $(MAKECMDGOALS)
