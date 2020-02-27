.PHONY: all clean download_archive mrproper before after layer

SUBDIRS=$(shell ls -d adm [0-9][0-9][0-9][0-9]_* 2>/dev/null)
MAKEFILE_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
LAYER_DIR_NAME:=$(shell basename $(MAKEFILE_DIR))
export LAYER_NAME := $(shell echo $(LAYER_DIR_NAME) |sed 's/^layer[0-9]_//g')

LAYER_PROFILES := $(wildcard .layerapi2_label) $(wildcard .extra_dependencies) $(wildcard .system_dependencies) $(wildcard .layerapi2_conflicts) $(wildcard .layerapi2_dependencies) $(wildcard .layerapi2_extra_env) $(wildcard .layerapi2_interactive_profile) $(wildcard .layerapi2_interactive_unprofile) $(wildcard .build_extra_dependencies)
TARGET_LAYER_PROFILES := $(addprefix $(MFMODULE_HOME)/opt/$(LAYER_NAME)/,$(LAYER_PROFILES))
DHASH_IGNORES := $(wildcard dhash_ignore_*)
TARGET_DHASH_IGNORES := $(addprefix $(MFMODULE_HOME)/opt/$(LAYER_NAME)/.,$(DHASH_IGNORES))

BYPASS = 0
space = $(empty) $(empty)
MISSING_LAYERS = 
DISPO_LAYERS = 

ifneq ("$(wildcard .bypass_build_if_missing)","")
    $(foreach layer, $(shell ls ${MFEXT_HOME}/opt) root, $(eval DISPO_LAYERS += ${layer}@mfext))
    $(if $(findstring ${MFMODULE_LOWERCASE},${MFEXT_HOME}),,$(foreach layer, $(shell ls ${MFMODULE_HOME}/opt) root, $(eval DISPO_LAYERS += ${layer}@${MFMODULE_LOWERCASE})))
    BYPASS_LAYERS = $(shell cat .bypass_build_if_missing)
    $(foreach layer, ${BYPASS_LAYERS}, $(if $(findstring ${space}${layer},${DISPO_LAYERS}),,$(eval BYPASS = 1);$(eval MISSING_LAYERS += ${layer})))
endif

ifeq ($(BYPASS), 0)

all: before layer after

else

all:
    $(info layer ${LAYER_NAME}@${MFMODULE_LOWERCASE} not built because of missing layers${MISSING_LAYERS})

endif

layer:
	if ! test -f cache/hit; then \
		for SUBDIR in $(SUBDIRS); do \
			OLDPWD=`pwd`; \
			cd $$SUBDIR || exit 1; \
			$(MAKE) all || exit 1; \
			cd $${OLDPWD}; \
		done ; \
		chmod -R a+rX,g-w,o-w,u+w $(MFMODULE_HOME)/opt/$(LAYER_NAME) ; \
	fi
	if test "$(MFEXT_ADDON)" = "1"; then echo $(MFEXT_ADDON_NAME) > $(MFMODULE_HOME)/opt/$(LAYER_NAME)/.mfextaddon; fi
	_layer_dhash "$(LAYER_NAME)@$(MFMODULE_LOWERCASE)" >$(MFMODULE_HOME)/opt/$(LAYER_NAME)/.dhash

before: $(TARGET_LAYER_PROFILES) $(TARGET_DHASH_IGNORES)
	_cache_logic_before_layer.sh "$(MFMODULE_HOME)/opt/$(LAYER_NAME)" "$(LAYER_NAME)"

after:
	if ! test -f cache/hit; then \
		_check_layers_hash >/dev/null ; \
	fi
	_cache_logic_after_layer.sh "$(MFMODULE_HOME)/opt/$(LAYER_NAME)"

clean:
	for SUBDIR in $(SUBDIRS); do OLDPWD=`pwd`; cd $$SUBDIR || exit 1; $(MAKE) clean || exit 1; cd $${OLDPWD}; done

download_archive:
	for SUBDIR in $(SUBDIRS); do OLDPWD=`pwd`; cd $$SUBDIR || exit 1; $(MAKE) download || exit 1; cd $${OLDPWD}; done

mrproper: clean
	@if test "$(LAYER_NAME)" != ""; then \
		rm -Rf $(MFMODULE_HOME)/opt/$(LAYER_NAME); \
	fi

$(MFMODULE_HOME)/opt/$(LAYER_NAME)/%: %
	@mkdir -p $(shell dirname $@)
	if test "$(MFMODULE)" = "MFEXT" -a "$(MFEXT_ADDON)" != "1"; then cat $< |$(SRC_DIR)/adm/envtpl --reduce-multi-blank-lines >$@; else cat $< |$(MFEXT_HOME)/bin/envtpl --reduce-multi-blank-lines >$@; fi

$(MFMODULE_HOME)/opt/$(LAYER_NAME)/.%: %
	@mkdir -p $(shell dirname $@)
	if test "$(MFMODULE)" = "MFEXT" -a "$(MFEXT_ADDON)" != "1"; then cat $< |$(SRC_DIR)/adm/envtpl --reduce-multi-blank-lines >$@; else cat $< |$(MFEXT_HOME)/bin/envtpl --reduce-multi-blank-lines >$@; fi

doc:
	_doc_layer.sh $(LAYER_NAME) >$(SRC_DIR)/doc/layer_$(LAYER_NAME).md
