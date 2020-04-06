.PHONY: freeze clean prerelease_check all superclean

NAME:=$(shell cat .layerapi2_label |sed 's/^plugin_//g' |awk -F '@' '{print $$1;}')
VERSION:=$(shell config.py config.ini general _version 2>/dev/null |sed "s/{{MFMODULE_VERSION}}/$${MFMODULE_VERSION}/g")
ifeq ($(VERSION),)
VERSION:=$(shell config.py config.ini general version 2>/dev/null |sed "s/{{MFMODULE_VERSION}}/$${MFMODULE_VERSION}/g")
endif

RELEASE:=1

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
ifneq ("$(wildcard python2_virtualenv_sources/requirements-to-freeze.txt)","")
	REQUIREMENTS2:=python2_virtualenv_sources/requirements2.txt
else
	REQUIREMENTS2:=
endif
ifneq ("$(REQUIREMENTS2)","")
	PREREQ+=$(REQUIREMENTS2) python2_virtualenv_sources/src
	DEPLOY+=local/lib/python$(PYTHON2_SHORT_VERSION)/site-packages/requirements2.txt
endif
ifneq ("$(wildcard package.json)","")
	PREREQ+=package-lock.json
	PREREQ+=node_modules
endif
LAYERS=$(shell cat .layerapi2_dependencies |tr '\n' ',' |sed 's/,$$/\n/')

all: $(PREREQ) custom $(DEPLOY)

.plugin_format_version:
	echo $(MFMODULE_VERSION) >$@

clean::
	rm -Rf local *.plugin *.tar.gz python?_virtualenv_sources/*.tmp python?_virtualenv_sources/src python?_virtualenv_sources/freezed_requirements.* python?_virtualenv_sources/tempolayer* tmp_build node_modules
	find . -type d -name "__pycache__" -exec rm -Rf {} \; >/dev/null 2>&1 || true

custom::
	@echo "override me" >/dev/null

superclean: clean
	rm -Rf python?_virtualenv_sources/requirements?.txt package-lock.json

local/lib/python$(PYTHON3_SHORT_VERSION)/site-packages/requirements3.txt: $(REQUIREMENTS3) python3_virtualenv_sources/src
	_install_plugin_virtualenv $(NAME) $(VERSION) $(RELEASE)
	# to force an autorestart
	touch config.ini

local/lib/python$(PYTHON2_SHORT_VERSION)/site-packages/requirements2.txt: $(REQUIREMENTS2) python2_virtualenv_sources/src
	_install_plugin_virtualenv $(NAME) $(VERSION) $(RELEASE)
	# to force an autorestart
	touch config.ini

python3_virtualenv_sources/requirements3.txt: python3_virtualenv_sources/requirements-to-freeze.txt
	cd python3_virtualenv_sources && layer_wrapper --empty --layers=$(LAYERS) -- freeze_requirements requirements-to-freeze.txt >requirements3.txt || { echo "ERROR with freeze_requirements"; rm -f requirements3.txt; exit 1; }

python2_virtualenv_sources/requirements2.txt: python2_virtualenv_sources/requirements-to-freeze.txt
	cd python2_virtualenv_sources && layer_wrapper --empty --layers=$(LAYERS) -- freeze_requirements requirements-to-freeze.txt >requirements2.txt || { echo "ERROR with freeze_requirements"; rm -f requirements2.txt; exit 1; }

python3_virtualenv_sources/src: $(REQUIREMENTS3)
	if test -f python3_virtualenv_sources/requirements3.txt; then \
	    cd python3_virtualenv_sources && layer_wrapper --empty --layers=$(LAYERS) -- download_compile_requirements requirements3.txt; \
	fi

python2_virtualenv_sources/src: $(REQUIREMENTS2)
	if test -f python2_virtualenv_sources/requirements2.txt; then \
	    cd python2_virtualenv_sources && layer_wrapper --empty --layers=$(LAYERS) -- download_compile_requirements requirements2.txt; \
	fi

package-lock.json: package.json
	rm -f $@
	export LAYERAPI2_LAYERS_PATH=`pwd`:$(LAYERAPI2_LAYERS_PATH) ; plugin_wrapper $(NAME) -- npm install

node_modules: package-lock.json
	rm -Rf node_modules
	export LAYERAPI2_LAYERS_PATH=`pwd`:$(LAYERAPI2_LAYERS_PATH) ; plugin_wrapper $(NAME) -- npm install

prerelease_check:
	@N=`plugins.info $(NAME) 2>/dev/null |wc -l` ; if test $${N} -gt 0; then echo "ERROR: please uninstall the plugin before doing 'make release'" ; exit 1; fi

release: prerelease_check clean $(PREREQ) custom
	layer_wrapper --empty --layers=$(LAYERS) -- _plugins.make --show-plugin-path --ignored-files-path=.releaseignore

develop: $(PREREQ) custom $(DEPLOY)
	_plugins.develop $(NAME)
