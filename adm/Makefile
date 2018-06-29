LIBS=bash_utils.sh
BINS=guess_version.sh _make_file_from_template.sh envtpl
SHARES=main_root.mk subdir_root.mk

include root.mk
include subdir_root.mk

TEMPLATES=$(shell find templates ! -type d)
TARGET_TEMPLATES:=$(addprefix $(MFEXT_HOME)/share/,$(TEMPLATES))

all:: $(TARGET_TEMPLATES) $(PREFIX)/share/profile

test:
	layer_wrapper --layers=devtools@mfext -- noutf8.sh
	layer_wrapper --layers=devtools@mfext -- shellchecks
	layer_wrapper --layers=devtools@mfext -- shellcheck envtpl
	layer_wrapper --layers=devtools@mfext -- shellcheck $(MFEXT_HOME)/share/profile
