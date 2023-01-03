.PHONY: freeze clean prerelease_check all superclean check custom precustom

NAME:=$(shell cat .layerapi2_label 2>/dev/null |sed 's/^plugin_//g' |awk -F '@' '{print $$1;}')
ifeq ($(NAME),)
	PWD=$(shell pwd)
	NAME:=$(shell basename $(PWD))
endif

VERSION:=$(shell config.py config.ini general _version 2>/dev/null |sed "s/{{MFMODULE_VERSION}}/$${MFMODULE_VERSION}/g")
ifeq ($(VERSION),)
VERSION:=$(MFMODULE_VERSION)
endif

RELEASE:=$(shell config.py config.ini general _release 2>/dev/null)
ifeq ($(RELEASE),)
RELEASE:=1
endif

PREREQ:=.plugin_format_version
DEPLOY:=
ifneq ("$(wildcard python3_virtualenv_sources/requirements-to-freeze.txt)","")
	REQUIREMENTS3:=python3_virtualenv_sources/requirements3.txt
else
	REQUIREMENTS3:=
endif
ifneq ("$(REQUIREMENTS3)","")
	PREREQ+=$(REQUIREMENTS3) python3_virtualenv_sources/src
	DEPLOY+=local/lib/python$(PYTHON3_SHORT_VERSION)/site-packages/requirements3.txt
endif
ifneq ("$(wildcard package.json)","")
	PREREQ+=package-lock.json
	PREREQ+=node_modules
endif
LAYERS=$(shell ( echo "root@$(MFMODULE_LOWERCASE)" ; cat .layerapi2_dependencies ) |tr '\n' ',' |sed 's/,$$/\n/')

all: precustom check $(PREREQ) custom $(DEPLOY)

.plugin_format_version:
	echo $(MFMODULE_VERSION) >$@

clean::
	@rm -Rf local *.plugin *.tar.gz python?_virtualenv_sources/*.tmp python?_virtualenv_sources/src python?_virtualenv_sources/freezed_requirements.* python?_virtualenv_sources/tempolayer* tmp_build node_modules .configuration_cache
	@find . -type d -name "__pycache__" -exec rm -Rf {} \; >/dev/null 2>&1 || true

precustom::
	@echo "override me" >/dev/null

custom::
	@echo "override me" >/dev/null

superclean: clean
	@rm -Rf python?_virtualenv_sources/requirements?.txt package-lock.json

local/lib/python$(PYTHON3_SHORT_VERSION)/site-packages/requirements3.txt: $(REQUIREMENTS3) python3_virtualenv_sources/src
	@_install_plugin_virtualenv $(NAME) $(VERSION) $(RELEASE)
	@# to force an autorestart
	@touch config.ini

python3_virtualenv_sources/requirements3.txt: python3_virtualenv_sources/requirements-to-freeze.txt
	@cd python3_virtualenv_sources && layer_wrapper --empty --layers=$(LAYERS) -- freeze_requirements requirements-to-freeze.txt >requirements3.txt || { echo "ERROR with freeze_requirements"; rm -f requirements3.txt; exit 1; }

python3_virtualenv_sources/src: $(REQUIREMENTS3)
	@if test -f python3_virtualenv_sources/requirements3.txt; then \
	    cd python3_virtualenv_sources && layer_wrapper --empty --layers=$(LAYERS) -- download_compile_requirements requirements3.txt; \
	fi

package-lock.json: package.json
	@rm -f $@
	@plugin_wrapper "$(shell pwd)" -- npm install

node_modules: package-lock.json
	@rm -Rf node_modules
	plugin_wrapper "$(shell pwd)" -- npm install

prerelease_check:
	@HOME=$(plugins.info --just-home "$(NAME)" || true) ; if test -L "$${HOME}"; then echo "ERROR: the plugin is devlinked, please uninstall the plugin before doing 'make release'" ; exit 1; fi

release: precustom check prerelease_check clean precustom $(PREREQ) custom
	@$(MAKE) precustom
	layer_wrapper --empty --layers=python3@mfext,root@$(MFMODULE_LOWERCASE) -- _plugins.make --show-plugin-path

develop: precustom check $(PREREQ) custom $(DEPLOY)
	@_plugins.develop --ignore-already-installed $(NAME)

check:
	@plugins.check .
