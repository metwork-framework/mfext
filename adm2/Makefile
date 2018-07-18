BINS=_launch_crontab clear.sh metwork_debug _doc_layer.sh _yaml_to_md.py
SHARES=_metwork.spec

include ../adm/root.mk
include ../adm/subdir_root.mk

TEMPLATES=$(shell find templates ! -type d)
TARGET_TEMPLATES:=$(addprefix $(MFEXT_HOME)/share/,$(TEMPLATES))

all:: profiles load_env $(TARGET_TEMPLATES) $(PREFIX)/share/profile

test:
	layer_wrapper --layers=devtools@mfext -- noutf8.sh
	layer_wrapper --layers=devtools@mfext -- shellchecks
	layer_wrapper --layers=devtools@mfext -- shellcheck _launch_crontab
	layer_wrapper --layers=devtools@mfext -- shellcheck $(MFEXT_HOME)/share/profile
