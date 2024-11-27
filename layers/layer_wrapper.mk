export PATH := $(MFEXT_HOME)/bin:$(MFEXT_HOME)/opt/core/bin:$(SRC_DIR)/bootstrap/bin:/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin
unexport LD_LIBRARY_PATH
unexport PKG_CONFIG_PATH
export FORCED_PATHS := yes

# hack around pwd versus $(PWD) to support some symbolic links
# see https://stackoverflow.com/questions/8390502/how-to-make-gnu-make-stop-de-referencing-symbolic-links-to-directories
_PWD=$(PWD)
_PARENT_PWD=$(shell dirname $(_PWD))

LAYERS_TO_LOAD=$(shell cat $(_PARENT_PWD)/.layerapi2_dependencies $(_PARENT_PWD)/.build_extra_dependencies .build_extra_dependencies 2>/dev/null |grep '^[a-zA-Z0-9]' |xargs |sed 's/ /,/g')
CURRENT_LAYER=$(shell cat $(_PARENT_PWD)/.layerapi2_label)

#Use gcc-toolset-11 if gcc version < 11
GCC_VERSION=`gcc --version | head -1 | cut -d" " -f3 | cut -d"." -f1`

ifeq ($(shell expr $(GCC_VERSION) = "8" ), 1)
    export SCL='scl enable gcc-toolset-11 --'
else ifeq ($(shell expr $(GCC_VERSION) = "9" ), 1)
    export SCL='scl enable gcc-toolset-11 --'
else ifeq ($(shell expr $(GCC_VERSION) = "10" ), 1)
    export SCL='scl enable gcc-toolset-11 --'
else
    export SCL=''
endif

.DEFAULT_GOAL := all

clean:
	$(MAKE) -f Makefile.mk clean

.DEFAULT:
	layer_wrapper --empty-env --empty-env-keeps=LANG,PATH,LAYERAPI2_LAYERS_PATH,PYTHON3_SHORT_VERSION,FORCED_PATHS,BUILDCACHE --force-prepend --layers=$(LAYERS_TO_LOAD),$(CURRENT_LAYER) -- $(subst ',,$(SCL)) make -f Makefile.mk $(MAKECMDGOALS)

test:
	layer_wrapper --empty-env --empty-env-keeps=LANG,PATH,LAYERAPI2_LAYERS_PATH,PYTHON3_SHORT_VERSION,FORCED_PATHS,BUILDCACHE --force-prepend --layers=$(LAYERS_TO_LOAD),$(CURRENT_LAYER),devtools@mfext -- $(subst ',,$(SCL)) make -f Makefile.mk test
