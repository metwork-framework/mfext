LIBS=bash_utils.sh
BINS=guess_version.sh _make_file_from_template.sh envtpl _proxy_set.sh
SHARES=main_root.mk subdir_root.mk

include root.mk
include subdir_root.mk

test:
	layer_wrapper --layers=devtools@mfext -- noutf8.sh
	layer_wrapper --layers=devtools@mfext -- shellchecks
	layer_wrapper --layers=devtools@mfext -- shellcheck envtpl
