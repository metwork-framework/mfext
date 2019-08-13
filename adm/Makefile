LIBS_BEFORE=bash_utils.sh
BINS_BEFORE=guess_version.sh _make_file_from_template.sh envtpl _proxy_set.sh dhash layer_hash _cache_path.sh _cache_logic_before.sh _cache_logic_after.sh _cache_logic_before_layer.sh _cache_logic_after_layer.sh _layer_hash module_hash _layer_dhash _check_layers_hash
SHARES_BEFORE=main_root.mk subdir_root.mk

LIBS=$(LIBS_BEFORE)
BINS=$(BINS_BEFORE) outside metwork_debug _launch_crontab clear.sh _doc_layer.sh _yaml_to_md.py
SHARES=$(SHARES_BEFORE) _metwork.spec

include root.mk
include subdir_root.mk

TARGET_BINS_BEFORE:=$(addprefix $(MFEXT_HOME)/bin/,$(BINS_BEFORE))
TARGET_SHARES_BEFORE:=$(addprefix $(MFEXT_HOME)/share/,$(SHARES_BEFORE))
TARGET_LIBS_BEFORE:=$(addprefix $(MFEXT_HOME)/lib/,$(LIBS_BEFORE))

TEMPLATES=$(shell find templates ! -type d)
TARGET_TEMPLATES:=$(addprefix $(MFEXT_HOME)/share/,$(TEMPLATES))

all:: profiles load_env $(TARGET_TEMPLATES) $(PREFIX)/share/profile

before_layers: $(TARGET_BINS_BEFORE) $(TARGET_SHARES_BEFORE) $(TARGET_LIBS_BEFORE)

test:
	layer_wrapper --layers=devtools@mfext -- noutf8.sh
	layer_wrapper --layers=devtools@mfext -- shellchecks
	layer_wrapper --layers=devtools@mfext -- shellcheck envtpl
	layer_wrapper --layers=devtools@mfext -- shellcheck _launch_crontab
	layer_wrapper --layers=devtools@mfext -- shellcheck $(MFEXT_HOME)/share/profile
