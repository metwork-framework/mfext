.PHONY: all clean download_archive mrproper before after layer

SUBDIRS=$(shell ls -d adm [0-9][0-9][0-9][0-9]_* 2>/dev/null)
MAKEFILE_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
LAYER_DIR_NAME:=$(shell basename $(MAKEFILE_DIR))
export LAYER_NAME := $(shell echo $(LAYER_DIR_NAME) |sed 's/^layer[0-9]_//g')
LAYER_HASH := $(shell $(SRC_DIR)/adm/layer_hash.sh $(LAYER_DIR_NAME) 2>/dev/null || echo null)

LAYER_PROFILES := $(wildcard .layerapi2_label) $(wildcard .layerapi2_conflicts) $(wildcard .layerapi2_dependencies) $(wildcard .layerapi2_extra_env) $(wildcard .layerapi2_interactive_profile) $(wildcard .layerapi2_interactive_unprofile)
TARGET_LAYER_PROFILES := $(addprefix $(MODULE_HOME)/opt/$(LAYER_NAME)/,$(LAYER_PROFILES))

all: before layer after

layer: $(TARGET_LAYER_PROFILES)
	if ! test -f $(MODULE_HOME)/opt/layer_$(LAYER_HASH).tar.gz; then \
		for SUBDIR in $(SUBDIRS); do \
		    OLDPWD=`pwd`; \
			cd $$SUBDIR || exit 1; \
			$(MAKE) all || exit 1; \
			cd $${OLDPWD}; \
		done; \
	fi

before:
	if ! test -d "$(MODULE_HOME)/opt/$(LAYER_NAME)"; then \
		if test "$(MODULE)" = "MFEXT"; then \
			if test "$(LAYER_HASH)" != "null"; then \
				cp -f /buildcache/layer_$(LAYER_HASH).tar.gz $(MFEXT_HOME)/opt/layer_$(LAYER_HASH).tar.gz || echo "no cache"; \
				if test -f "$(MFEXT_HOME)/opt/layer_$(LAYER_HASH).tar.gz"; then \
					cd $(MFEXT_HOME)/opt && zcat layer_$(LAYER_HASH).tar.gz |tar xf - ; \
					cd $(MFEXT_HOME)/opt/$(LAYER_NAME) && touch .layerapi2_* ; \
				fi; \
			fi; \
		fi; \
	fi
	if ! test -d "$(MODULE_HOME)/opt/$(LAYER_NAME)"; then mkdir -p $(MODULE_HOME)/opt/$(LAYER_NAME); fi
	#if test "$(MODULE)" = "MFEXT" -a "$(LAYER_HASH)" != "null"; then chmod -R u+w "$(MFEXT_HOME)/opt/$(LAYER_NAME)"; fi

after:
	#if test "$(MODULE)" = "MFEXT" -a "$(LAYER_HASH)" != "null"; then chmod -R a-w "$(MFEXT_HOME)/opt/$(LAYER_NAME)"; fi
	if test "$(MODULE)" = "MFEXT"; then \
		if test "$(LAYER_HASH)" != "null"; then \
			if ! test -f "$(MFEXT_HOME)/opt/layer_$(LAYER_HASH).tar.gz"; then \
				cd $(MFEXT_HOME)/opt && tar -cf layer_$(LAYER_HASH).tar $(LAYER_NAME) && gzip -f layer_$(LAYER_HASH).tar; \
				cd $(MFEXT_HOME)/opt && cp -f layer_$(LAYER_HASH).tar.gz /buildcache/layer_$(LAYER_HASH).tar.gz || echo "no cache"; \
				rm -f layer_$(LAYER_HASH).tar.gz; \
			fi \
		fi \
	fi
	if test -f $(MODULE_HOME)/opt/layer_$(LAYER_HASH).tar.gz; then rm -f $(MODULE_HOME)/opt/layer_$(LAYER_HASH).tar.gz; fi

clean:
	for SUBDIR in $(SUBDIRS); do OLDPWD=`pwd`; cd $$SUBDIR || exit 1; $(MAKE) clean || exit 1; cd $${OLDPWD}; done

download_archive:
	for SUBDIR in $(SUBDIRS); do OLDPWD=`pwd`; cd $$SUBDIR || exit 1; $(MAKE) download || exit 1; cd $${OLDPWD}; done

mrproper: clean
	@if test "$(LAYER_NAME)" != ""; then \
		#if test "$(LAYER_HASH)" != "null"; then \
		#	chmod -R u+w $(MODULE_HOME)/opt/$(LAYER_NAME); \
		#fi;
		rm -Rf $(MODULE_HOME)/opt/$(LAYER_NAME); \
	fi

	#if test "$(LAYER_NAME)" != "" -a "$(LAYER_HASH)" != "null"; then chmod -R u+w $(MODULE_HOME)/opt/$(LAYER_NAME) ; rm -Rf $(MODULE_HOME)/opt/$(LAYER_NAME); fi
	if test "$(LAYER_NAME)" != "" -a "$(LAYER_HASH)" != "null"; then rm -Rf $(MODULE_HOME)/opt/$(LAYER_NAME); fi

$(MODULE_HOME)/opt/$(LAYER_NAME)/%: %
	@mkdir -p $(shell dirname $@)
	if test "$(MODULE)" = "MFEXT"; then cat $< |$(SRC_DIR)/adm/envtpl >$@; else cat $< |$(MFEXT_HOME)/bin/envtpl >$@; fi

doc:
	_doc_layer.sh $(LAYER_NAME) >$(SRC_DIR)/doc/layer_$(LAYER_NAME).md
