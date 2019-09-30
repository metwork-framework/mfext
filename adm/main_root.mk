.PHONY: coverage _coverage clean all before after mrproper doc test archive rpm
SHELL := /bin/bash

ifeq ($(VERSION_BUILD),)
    export VERSION_BUILD=$(shell $(MFEXT_HOME)/bin/guess_version.sh 2>/dev/null)
endif
ifeq ($(RELEASE_BUILD),)
    export RELEASE_BUILD=1
endif
ifeq ($(MFMODULE_LOWERCASE),)
	export MFMODULE_LOWERCASE=mfext
endif
ifeq ($(MODULE_HAS_HOME_DIR),)
    export MODULE_HAS_HOME_DIR=0
endif
ARCHIV=$(MFMODULE_LOWERCASE)-$(VERSION_BUILD)-$(RELEASE_BUILD)

LAYERAPI2_FILES := $(wildcard .layerapi2_label) $(wildcard .layerapi2_dependencies) $(wildcard .layerapi2_conflicts)
TARGET_LAYERAPI2_FILES := $(addprefix $(MFMODULE_HOME)/,$(LAYERAPI2_FILES))

default:: before all after
all:: ;
clean:: ;
before:: adm/root.mk $(TARGET_LAYERAPI2_FILES);

$(MFMODULE_HOME)/.layerapi2_label:
	cp -f .layerapi2_label $(MFMODULE_HOME)/.layerapi2_label

$(MFMODULE_HOME)/.layerapi2_conflicts:
	cp -f .layerapi2_conflicts $(MFMODULE_HOME)/.layerapi2_conflicts

$(MFMODULE_HOME)/.layerapi2_dependencies:
	cp -f .layerapi2_dependencies $(MFMODULE_HOME)/.layerapi2_dependencies

adm/root.mk:
	@echo "ERROR: you have to execute ./bootstrap.sh first"
	exit 1

after:: ;
	if test "$(MFEXT_ADDON)" != "1"; then _layer_dhash root@$(MFMODULE_LOWERCASE) >$(MFMODULE_HOME)/.dhash; fi
	@mkdir -p .metwork-framework
	layer_wrapper --layers=python3_devtools@mfext -- _yaml_to_md.py --not-sphinx ALL >.metwork-framework/components.md

mrproper:: clean
	if test "$(MFEXT_ADDON)" != ""; then $(MAKE) _addon_mrproper; else $(MAKE) _mrproper; fi

_mrproper:
	rm -Rf $(MFMODULE_HOME)/bin
	rm -Rf $(MFMODULE_HOME)/sbin
	rm -Rf $(MFMODULE_HOME)/lib
	rm -Rf $(MFMODULE_HOME)/lib64
	rm -Rf $(MFMODULE_HOME)/build*
	rm -Rf $(MFMODULE_HOME)/share
	rm -Rf $(MFMODULE_HOME)/include
	rm -Rf $(MFMODULE_HOME)/opt
	rm -Rf $(MFMODULE_HOME)/www
	rm -Rf $(MFMODULE_HOME)/config
	rm -Rf $(MFMODULE_HOME)/config_auto
	rm -Rf $(MFMODULE_HOME)/doc
	rm -Rf $(MFMODULE_HOME)/man
	rm -Rf $(MFMODULE_HOME)/etc
	rm -Rf $(MFMODULE_HOME)/var
	rm -Rf $(MFMODULE_HOME)/tmp
	rm -Rf $(MFMODULE_HOME)/html_doc
	rm -Rf $(MFMODULE_HOME)/libexec
	rm -Rf $(MFMODULE_HOME)/cgi-bin
	rm -f $(MFMODULE_HOME)/mf*_link
	rm -f $(MFMODULE_HOME)/.layerapi2_*

_addon_mrproper:
	for L in $(MFMODULE_HOME)/opt/*; do A=`cat $${L}/.mfextaddon 2>/dev/null`; if test "$(MFEXT_ADDON_NAME)" != "" -a "$${A}" = "$(MFEXT_ADDON_NAME)"; then rm -Rf "$${L}"; fi; done

doc:: predoc
	cd doc && make clean
	layer_wrapper --layers=python3_devtools@mfext -- _yaml_to_md.py $(MFMODULE_HOME) >packages.md
	_doc_layer.sh root >$(SRC_DIR)/doc/layer_root.md
	if test "$(MFEXT_ADDON)" != "1"; then _doc_layer.sh root >$(SRC_DIR)/doc/layer_root.md; fi
	rm -f packages.md
	if test -d layers; then cd layers && $(MAKE) doc; fi
	if test -d extra_layers; then cd extra_layers && $(MAKE) doc; fi
	if test -d doc; then cd doc && layer_wrapper --layers=devtools@mfext,-python3@$(MFMODULE_LOWERCASE) -- make html && rm -Rf $(MFMODULE_HOME)/html_doc && cp -Rf _build/html $(MFMODULE_HOME)/html_doc; fi

predoc:: ;

test::
	layer_wrapper --layers=devtools@mfext -- shellcheck bootstrap.sh

coverage:: ;
_coverage: coverage
	rm -Rf $(MFMODULE_HOME)/html_coverage
	if test -d coverage; then cp -Rf coverage $(MFMODULE_HOME)/html_coverage; fi


####################################
##### FABRICATION DE L'ARCHIVE #####
####################################
archive: $(MFMODULE_HOME)/$(ARCHIV)-linux64.tar
$(MFMODULE_HOME)/$(ARCHIV)-linux64.tar:
	rm -Rf $(MFMODULE_HOME)/$(ARCHIV) ; mkdir $(MFMODULE_HOME)/$(ARCHIV)
	for REP in $(MFMODULE_HOME)/*; do \
		if test "$(MFEXT_ADDON)" = "1"; then continue; fi; \
		if ! test -d "$${REP}"; then continue; fi; \
		if test "$${REP}" = "$(MFMODULE_HOME)/build"; then continue; fi; \
		if test "$${REP}" = "$(MFMODULE_HOME)/src"; then continue; fi; \
		if [[ $${REP} = $(MFMODULE_HOME)/$(MFMODULE_LOWERCASE)-* ]]; then continue; fi; \
		cp -Rpf $${REP} $(MFMODULE_HOME)/$(ARCHIV)/; \
	done
	if test "$(MFEXT_ADDON)" = "1"; then \
		mkdir -p $(MFMODULE_HOME)/$(ARCHIV)/opt; \
		for REP in $(MFMODULE_HOME)/opt/*; do \
		    if ! test -d "$${REP}"; then continue; fi; \
			if ! test -f $${REP}/.mfextaddon; then continue; fi; \
			if test "`cat $${REP}/.mfextaddon 2>/dev/null`" != "$(MFEXT_ADDON_NAME)"; then continue; fi; \
			cp -Rpf $${REP} $(MFMODULE_HOME)/$(ARCHIV)/opt/; \
		done; \
	else \
		cp -f $(MFMODULE_HOME)/.layerapi2* $(MFMODULE_HOME)/$(ARCHIV)/; \
		cp -f $(MFMODULE_HOME)/.dhash* $(MFMODULE_HOME)/$(ARCHIV)/ 2>/dev/null || true; \
	fi
	chmod -R go-rwx $(MFMODULE_HOME)/$(ARCHIV)
	chmod -R ug+rX $(MFMODULE_HOME)/$(ARCHIV)
	chmod -R u+rwX $(MFMODULE_HOME)/$(ARCHIV)
	rm -f $(MFMODULE_HOME)/$(ARCHIV)/mf*_link
	rm -f $(MFMODULE_HOME)/$(ARCHIV)/*.tar
	rm -f $(MFMODULE_HOME)/$(ARCHIV)/*.rpm
	rm -Rf $(MFMODULE_HOME)/$(ARCHIV)/tmp >/dev/null 2>&1
	rm -Rf $(MFMODULE_HOME)/$(ARCHIV)/var >/dev/null 2>&1
	rm -Rf $(MFMODULE_HOME)/$(ARCHIV)/log >/dev/null 2>&1
	rm -Rf $(MFMODULE_HOME)/$(ARCHIV)/runtime >/dev/null 2>&1
	cd $(MFMODULE_HOME) && tar -cf $(ARCHIV)-linux64.tar $(ARCHIV)
	rm -Rf $(MFMODULE_HOME)/$(ARCHIV)


###############################
##### FABRICATION DU RPM ######
###############################
rpm: archive
	rm -Rf $(MFMODULE_HOME)/rpm
	mkdir $(MFMODULE_HOME)/rpm
	mkdir $(MFMODULE_HOME)/rpm/BUILD
	mkdir $(MFMODULE_HOME)/rpm/RPMS
	mkdir $(MFMODULE_HOME)/rpm/SRPMS
	mkdir $(MFMODULE_HOME)/rpm/SPECS
	mkdir $(MFMODULE_HOME)/rpm/SOURCES
	mkdir $(MFMODULE_HOME)/rpm/tmp
	echo '%_topdir $(MFMODULE_HOME)/rpm' >$(MFMODULE_HOME)/rpm/.rpmmacros
	cat $(MFEXT_HOME)/share/_metwork.spec | $(MFEXT_HOME)/bin/envtpl --reduce-multi-blank-lines >$(MFMODULE_HOME)/rpm/SPECS/metwork-$(MFMODULE_LOWERCASE).spec
	echo $(MFMODULE_HOME)/rpm/SPECS/metwork-$(MFMODULE_LOWERCASE).spec
	ln -s $(MFMODULE_HOME)/$(ARCHIV)-linux64.tar $(MFMODULE_HOME)/rpm/SOURCES/$(ARCHIV)-linux64.tar
	cd $(MFMODULE_HOME)/rpm/SPECS && export HOME=$(MFMODULE_HOME)/rpm && rpmbuild -bb metwork-$(MFMODULE_LOWERCASE).spec
	if test "$(MFEXT_ADDON)" = "1"; then rm -f $$(ls $(MFMODULE_HOME)/rpm/RPMS/x86_64/*.rpm |grep -v '\-layer\-'); fi
	cp -f $(MFMODULE_HOME)/rpm/RPMS/x86_64/*.rpm $(MFMODULE_HOME)/
	if test ! "$(DRONE)" = true; then rm -Rf $(MFMODULE_HOME)/rpm; fi
