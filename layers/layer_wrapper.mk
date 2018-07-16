export PATH := $(MFEXT_HOME)/bin:/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin
unexport LD_LIBRARY_PATH
unexport PKG_CONFIG_PATH
export FORCED_PATHS := yes
LAYERS_TO_LOAD=$(shell cat ../.layerapi2_dependencies |xargs |sed 's/ /,/g')
CURRENT_LAYER=$(shell cat ../.layerapi2_label)

.DEFAULT_GOAL := all

.DEFAULT:
	layer_wrapper --empty-env --empty-env-keeps=LANG,PATH,METWORK_LAYERS_PATH,PYTHON3_SHORT_VERSION,PYTHON2_SHORT_VERSION,FORCED_PATHS --force-prepend --layers=$(LAYERS_TO_LOAD),$(CURRENT_LAYER) -- make -f Makefile.mk $(MAKECMDGOALS)
