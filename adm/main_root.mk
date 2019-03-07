.PHONY: coverage _coverage clean all before after mrproper doc test archive rpm
SHELL := /bin/bash

ifeq ($(VERSION_BUILD),)
    export VERSION_BUILD=$(shell $(MFEXT_HOME)/bin/guess_version.sh 2>/dev/null)
endif
ifeq ($(RELEASE_BUILD),)
    export RELEASE_BUILD=1
endif
ifeq ($(MODULE_LOWERCASE),)
	export MODULE_LOWERCASE=mfext
endif
ifeq ($(MODULE_HAS_HOME_DIR),)
    export MODULE_HAS_HOME_DIR=0
endif
ifeq ($(EPOCH),)
    export EPOCH=6
endif
ARCHIV=$(MODULE_LOWERCASE)-$(VERSION_BUILD)-$(RELEASE_BUILD)

LAYERAPI2_FILES := $(wildcard .layerapi2_label) $(wildcard .layerapi2_dependencies) $(wildcard .layerapi2_conflicts)
TARGET_LAYERAPI2_FILES := $(addprefix $(MODULE_HOME)/,$(LAYERAPI2_FILES))

default:: before all after
all:: ;
clean:: ;
before:: adm/root.mk bootstrap.sh $(TARGET_LAYERAPI2_FILES);

$(MODULE_HOME)/.layerapi2_label:
	cp -f .layerapi2_label $(MODULE_HOME)/.layerapi2_label

$(MODULE_HOME)/.layerapi2_conflicts:
	cp -f .layerapi2_conflicts $(MODULE_HOME)/.layerapi2_conflicts

$(MODULE_HOME)/.layerapi2_dependencies:
	cp -f .layerapi2_dependencies $(MODULE_HOME)/.layerapi2_dependencies

adm/root.mk:
	@echo "ERROR: you have to execute ./bootstrap.sh first"
	exit 1

after:: ;

mrproper:: clean
	rm -Rf $(MODULE_HOME)/bin
	rm -Rf $(MODULE_HOME)/sbin
	rm -Rf $(MODULE_HOME)/lib
	rm -Rf $(MODULE_HOME)/lib64
	rm -Rf $(MODULE_HOME)/build*
	rm -Rf $(MODULE_HOME)/share
	rm -Rf $(MODULE_HOME)/include
	rm -Rf $(MODULE_HOME)/opt
	rm -Rf $(MODULE_HOME)/www
	rm -Rf $(MODULE_HOME)/config
	rm -Rf $(MODULE_HOME)/config_auto
	rm -Rf $(MODULE_HOME)/doc
	rm -Rf $(MODULE_HOME)/man
	rm -Rf $(MODULE_HOME)/etc
	rm -Rf $(MODULE_HOME)/var
	rm -Rf $(MODULE_HOME)/tmp
	rm -Rf $(MODULE_HOME)/html_doc
	rm -Rf $(MODULE_HOME)/libexec
	rm -Rf $(MODULE_HOME)/cgi-bin
	rm -f $(MODULE_HOME)/mf*_link
	rm -f $(MODULE_HOME)/.layerapi2_*

doc:: predoc
	layer_wrapper --layers=python3_devtools@mfext -- _yaml_to_md.py $(MODULE_HOME) >packages.md
	_doc_layer.sh root >$(SRC_DIR)/doc/layer_root.md
	rm -f packages.md
	if test -d layers; then cd layers && $(MAKE) doc; fi
	if test -d extra_layers; then cd extra_layers && $(MAKE) doc; fi
	if test -d doc; then cd doc && make clean && layer_wrapper --layers=devtools@mfext,-python3@$(MODULE_LOWERCASE) -- make html && rm -Rf $(MODULE_HOME)/html_doc && cp -Rf _build/html $(MODULE_HOME)/html_doc; fi

predoc:: ;

test::
	layer_wrapper --layers=devtools@mfext -- shellcheck bootstrap.sh

coverage:: ;
_coverage: coverage
	rm -Rf $(MODULE_HOME)/html_coverage
	if test -d coverage; then cp -Rf coverage $(MODULE_HOME)/html_coverage; fi

bootstrap.sh: $(wildcard bootstrap.custom)
	$(MFEXT_HOME)/bin/_make_file_from_template.sh bootstrap.sh .custom >$@
	chmod u+x $@

doc/Makefile: $(wildcard doc/Makefile.custom)
	$(MFEXT_HOME)/bin/_make_file_from_template.sh doc/Makefile .custom >$@

doc/conf.py: $(wildcard doc/conf.py)
	$(MFEXT_HOME)/bin/_make_file_from_template.sh doc/conf.py .custom >$@

prereq:
	rm -f bootstrap.sh doc/Makefile doc/conf.py
	$(MAKE) bootstrap.sh doc/Makefile doc/conf.py


####################################
##### FABRICATION DE L'ARCHIVE #####
####################################
archive: $(MODULE_HOME)/$(ARCHIV)-linux64.tar
$(MODULE_HOME)/$(ARCHIV)-linux64.tar:
	rm -Rf $(MODULE_HOME)/$(ARCHIV) ; mkdir $(MODULE_HOME)/$(ARCHIV)
	for REP in $(MODULE_HOME)/*; do \
		if test "$(MFEXT_ADDON)" = "1"; then continue; fi; \
		if ! test -d "$${REP}"; then continue; fi; \
		if test "$${REP}" = "$(MODULE_HOME)/build"; then continue; fi; \
		if test "$${REP}" = "$(MODULE_HOME)/src"; then continue; fi; \
		if [[ $${REP} = $(MODULE_HOME)/$(MODULE_LOWERCASE)-* ]]; then continue; fi; \
		cp -Rpf $${REP} $(MODULE_HOME)/$(ARCHIV)/; \
	done
	if test "$(MFEXT_ADDON)" = "1"; then \
		mkdir -p $(MODULE_HOME)/$(ARCHIV)/opt; \
		for REP in $(MODULE_HOME)/opt/*; do \
		    if ! test -d "$${REP}"; then continue; fi; \
			if ! test -f $${REP}/.mfextaddon; then continue; fi; \
			cp -Rpf $${REP} $(MODULE_HOME)/$(ARCHIV)/opt/; \
		done; \
	else \
		cp -f $(MODULE_HOME)/.layerapi2* $(MODULE_HOME)/$(ARCHIV)/; \
	fi
	chmod -R go-rwx $(MODULE_HOME)/$(ARCHIV)
	chmod -R ug+rX $(MODULE_HOME)/$(ARCHIV)
	chmod -R u+rwX $(MODULE_HOME)/$(ARCHIV)
	rm -f $(MODULE_HOME)/$(ARCHIV)/mf*_link
	rm -f $(MODULE_HOME)/$(ARCHIV)/*.tar
	rm -f $(MODULE_HOME)/$(ARCHIV)/*.rpm
	rm -Rf $(MODULE_HOME)/$(ARCHIV)/tmp >/dev/null 2>&1
	rm -Rf $(MODULE_HOME)/$(ARCHIV)/var >/dev/null 2>&1
	rm -Rf $(MODULE_HOME)/$(ARCHIV)/log >/dev/null 2>&1
	rm -Rf $(MODULE_HOME)/$(ARCHIV)/runtime >/dev/null 2>&1
	cd $(MODULE_HOME) && tar -cf $(ARCHIV)-linux64.tar $(ARCHIV)
	rm -Rf $(MODULE_HOME)/$(ARCHIV)


###############################
##### FABRICATION DU RPM ######
###############################
rpm: archive
	rm -Rf $(MODULE_HOME)/rpm
	mkdir $(MODULE_HOME)/rpm
	mkdir $(MODULE_HOME)/rpm/BUILD
	mkdir $(MODULE_HOME)/rpm/RPMS
	mkdir $(MODULE_HOME)/rpm/SRPMS
	mkdir $(MODULE_HOME)/rpm/SPECS
	mkdir $(MODULE_HOME)/rpm/SOURCES
	mkdir $(MODULE_HOME)/rpm/tmp
	echo '%_topdir $(MODULE_HOME)/rpm' >$(MODULE_HOME)/rpm/.rpmmacros
	if test "$(MODULE)" = "MFEXT" -a "$(MFEXT_ADDON)" != "1"; then cat $(MFEXT_HOME)/share/_metwork.spec |$(SRC_DIR)/layers/layer7_devtools/0000_penvtpl/bin/penvtpl >$(MODULE_HOME)/rpm/SPECS/metwork-$(MODULE_LOWERCASE).spec; else cat $(MFEXT_HOME)/share/_metwork.spec |envtpl >$(MODULE_HOME)/rpm/SPECS/metwork-$(MODULE_LOWERCASE).spec; fi
	ln -s $(MODULE_HOME)/$(ARCHIV)-linux64.tar $(MODULE_HOME)/rpm/SOURCES/$(ARCHIV)-linux64.tar
	cd $(MODULE_HOME)/rpm/SPECS && export HOME=$(MODULE_HOME)/rpm && rpmbuild -bb metwork-$(MODULE_LOWERCASE).spec
	if test "$(MFEXT_ADDON)" = "1"; then rm -f $$(ls $(MODULE_HOME)/rpm/RPMS/x86_64/*.rpm |grep -v '\-layer\-'); fi
	cp -f $(MODULE_HOME)/rpm/RPMS/x86_64/*.rpm $(MODULE_HOME)/
	if test ! "$(DRONE)" = true; then rm -Rf $(MODULE_HOME)/rpm; fi
