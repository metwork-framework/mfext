ifeq ($(PREFIX),)
	PREFIX:=$(MODULE_HOME)
endif
TARGET_BINS:=$(addprefix $(PREFIX)/bin/,$(BINS))
TARGET_SBINS:=$(addprefix $(PREFIX)/sbin/,$(SBINS))
TARGET_SHARES:=$(addprefix $(PREFIX)/share/,$(SHARES))
TARGET_CONFIGS:=$(addprefix $(PREFIX)/config/,$(CONFIGS))
TARGET_LIBS:=$(addprefix $(PREFIX)/lib/,$(LIBS))
TARGET_INCLUDES:=$(addprefix $(PREFIX)/include/,$(INCLUDES))
TARGET_PKGCONFIGS:=$(addprefix $(PREFIX)/include/,$(PKGCONFIGS))

PROFILE_TEMPLATE=profile
INTERACTIVE_PROFILE_TEMPLATE=interactive_profile

all:: install-sbins install-bins install-shares install-configs install-libs install-includes install-pkgconfigs
install: all
build: all

clean:: ;

profiles: $(PREFIX)/share/bashrc $(PREFIX)/share/bash_profile $(PREFIX)/share/profile $(PREFIX)/share/interactive_profile

pythonclean::
	rm -rf build dist *.egg-info
	rm -f `find -name "*.pyc"`
	rm -rf `find -name "__pycache__"`
	rm -rf tests/.coverage tests/coverage

install-bins: $(TARGET_BINS)
$(PREFIX)/bin/%: %
	@mkdir -p $(shell dirname $@)
	cp -f $< $@
	chmod a+rx $@

install-sbins: $(TARGET_SBINS)
$(PREFIX)/sbin/%: %
	@mkdir -p $(shell dirname $@)
	cp -f $< $@
	chmod a+rx $@

install-includes: $(TARGET_INCLUDES)
$(PREFIX)/include/%: %
	@mkdir -p $(shell dirname $@)
	cp -f $< $@

install-pkgconfigs: $(TARGET_PKGCONFIGS)
$(PREFIX)/lib/pkgconfig/%: %
	@mkdir -p $(shell dirname $@)
	cp -f $< $@

install-shares: $(TARGET_SHARES)
$(PREFIX)/share/%: %
	@mkdir -p $(shell dirname $@)
	cp --preserve=mode -f $< $@

install-configs: $(TARGET_CONFIGS)
$(PREFIX)/config/%: %
	@mkdir -p $(shell dirname $@)
	cp -f $< $@

install-libs: $(TARGET_LIBS)
$(PREFIX)/lib/%: %
	@mkdir -p $(shell dirname $@)
	cp -f $< $@

$(PREFIX)/share/bashrc: $(MFEXT_HOME)/share/templates/bashrc $(wildcard bashrc.custom)
	@if ! test -d $(PREFIX)/share; then mkdir -vp $(PREFIX)/share; fi
	$(MFEXT_HOME)/bin/_make_file_from_template.sh bashrc .custom >$@

$(PREFIX)/share/bash_profile: $(MFEXT_HOME)/share/templates/bash_profile $(wildcard bash_profile.custom)
	@if ! test -d $(PREFIX)/share; then mkdir -vp $(PREFIX)/share; fi
	$(MFEXT_HOME)/bin/_make_file_from_template.sh bash_profile .custom >$@

$(PREFIX)/share/profile: $(MFEXT_HOME)/share/templates/$(PROFILE_TEMPLATE) $(MFEXT_HOME)/share/templates/config_profile $(MFEXT_HOME)/share/templates/nethard_profile $(wildcard $(PROFILE_TEMPLATE).custom)
	$(MFEXT_HOME)/bin/_make_file_from_template.sh $(PROFILE_TEMPLATE) .custom >$@

$(PREFIX)/share/interactive_profile: $(MFEXT_HOME)/share/templates/$(INTERACTIVE_PROFILE_TEMPLATE) $(wildcard $(INTERACTIVE_PROFILE_TEMPLATE).custom)
	$(MFEXT_HOME)/bin/_make_file_from_template.sh $(INTERACTIVE_PROFILE_TEMPLATE) .custom >$@

load_env: $(PREFIX)/share/load_env.sh $(PREFIX)/share/load_env_and_cd_sources.sh $(PREFIX)/share/load_env_and_cd_runtime.sh $(PREFIX)/bin/$(MODULE_LOWERCASE)_wrapper $(PREFIX)/bin/_$(MODULE_LOWERCASE)_wrapper

$(PREFIX)/bin/$(MODULE_LOWERCASE)_wrapper: $(MFEXT_HOME)/share/templates/mfxxx_wrapper
	$(MFEXT_HOME)/bin/_make_file_from_template.sh mfxxx_wrapper .custom >$@
	chmod a+rx $@

$(PREFIX)/bin/_$(MODULE_LOWERCASE)_wrapper: $(MFEXT_HOME)/share/templates/_mfxxx_wrapper
	$(MFEXT_HOME)/bin/_make_file_from_template.sh _mfxxx_wrapper .custom >$@
	chmod a+rx $@

$(PREFIX)/share/load_env.sh: $(MFEXT_HOME)/share/templates/load_env.sh
	export ROOT_DIR=$(PREFIX) && $(MFEXT_HOME)/bin/_make_file_from_template.sh load_env.sh .custom >$@

$(PREFIX)/share/load_env_and_cd_sources.sh: $(MFEXT_HOME)/share/templates/load_env.sh
	export ROOT_DIR=`pwd`/.. && $(MFEXT_HOME)/bin/_make_file_from_template.sh load_env.sh .custom >$@

$(PREFIX)/share/load_env_and_cd_runtime.sh: $(MFEXT_HOME)/share/templates/load_env.sh
	export ROOT_DIR=RUNTIME && $(MFEXT_HOME)/bin/_make_file_from_template.sh load_env.sh .custom >$@

$(PREFIX)/config/version:
	@mkdir -p $(PREFIX)/config
	guess_version.sh >$(PREFIX)/config/version || { rm -f $@ ; false ; }
