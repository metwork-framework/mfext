LIBS_BEFORE=bash_utils.sh
BINS_BEFORE=guess_version.sh _make_file_from_template.sh envtpl _proxy_set.sh dhash layer_hash _cache_path.sh _cache_logic_before_layer.sh _cache_logic_after_layer.sh _layer_hash module_hash _layer_dhash _check_layers_hash outside
SHARES_BEFORE=main_root.mk subdir_root.mk

LIBS=$(LIBS_BEFORE)
BINS=$(BINS_BEFORE) metwork_debug _launch_crontab clear.sh _doc_layer.sh _yaml_to_md.py _packaging_get_module_dependencies _packaging_get_module_layers _packaging_get_layer_dependencies _packaging_get_package_name components _circus.start _circus.stop _circus.status _ini_to_env.py before_start_redis before_start_nginx port_test.sh _make_and_install_crontab.sh _uninstall_crontab.sh circus_status_watcher.sh redis_status.sh config.py _prepare_config.py _make_nethard_config.py _make_circus_conf _make_crontab.py remove_empty.sh kill_remaining_processes.py bootstrap_plugin.py _make_nginx_conf bootstrap_plugin.post _circusctl _install_or_update_configured_plugins.py nginx.status find_zombies_nginx_workers.py before_start_telegraf _circus_wait_watcher_stopped.sh _circus_wait_watcher_stopped.py _circus_schedule_stop_watcher.sh _install_plugin_virtualenv _plugins.preuninstall _plugins.postinstall list_metwork_processes.py telegraf_collector_metwork_module.py _nginx.reload _circus.reload _plugins.is_dangerous _circus_wait_watcher_started.sh _circus_wait_watcher_started.py nginxfmt.py before_start_conf_monitor _no_automatic_kill.sh plugins.status _plugins.status _plugins.stop plugins.stop _plugins.start plugins.start _send_state.py _prepare_plugin_config.py _remove_plugin_config.py pip_wrapper _circus_schedule_start_watcher.py _circus_schedule_start_watcher.sh _circus_schedule_stop_watcher.py _circus_wait_watcher_started.py _circus_wait_watcher_stopped.py _circus_wait.py _circus_wait.sh wait_redis.py repeat.sh before_start_vector _module_status_json.py revert_ldd.sh
SHARES=startup_scripts_profiles.mk plugin.mk config_subdir.mk metwork.service
SHARES=$(SHARES_BEFORE) _metwork.spec startup_scripts_profiles.mk plugin.mk config_subdir.mk metwork.service

include root.mk
include subdir_root.mk

TARGET_BINS_BEFORE:=$(addprefix $(MFEXT_HOME)/bin/,$(BINS_BEFORE))
TARGET_SHARES_BEFORE:=$(addprefix $(MFEXT_HOME)/share/,$(SHARES_BEFORE))
TARGET_LIBS_BEFORE:=$(addprefix $(MFEXT_HOME)/lib/,$(LIBS_BEFORE))

TEMPLATES=$(shell find templates ! -type d)
TARGET_TEMPLATES:=$(addprefix $(MFEXT_HOME)/share/,$(TEMPLATES))

all:: profiles load_env $(TARGET_TEMPLATES) $(PREFIX)/share/profile $(PREFIX)/lib/mfext/__init__.py $(PREFIX)/lib/mfext/ini_to_env.py $(PREFIX)/lib/mfext/circus_hooks.py $(PREFIX)/lib/mfext/mflog_addon.py $(PREFIX)/lib/mfext/conf_monitor.py $(PREFIX)/lib/mfext/circus.py $(PREFIX)/bin/metwork

before_layers: $(TARGET_BINS_BEFORE) $(TARGET_SHARES_BEFORE) $(TARGET_LIBS_BEFORE)

test:
	layer_wrapper --layers=devtools@mfext -- noutf8.sh
	layer_wrapper --layers=devtools@mfext -- shellchecks
	layer_wrapper --layers=devtools@mfext -- shellcheck envtpl
	layer_wrapper --layers=devtools@mfext -- shellcheck _launch_crontab
	layer_wrapper --layers=devtools@mfext -- shellcheck $(MFEXT_HOME)/share/profile

$(PREFIX)/bin/metwork: metwork
	cat $< | $(MFEXT_HOME)/bin/envtpl >$@

$(PREFIX)/lib/mfext/__init__.py:
	mkdir -p $(PREFIX)/lib/mfext
	touch $@

$(PREFIX)/lib/mfext/ini_to_env.py: ini_to_env.py
	cp -f $< $@

$(PREFIX)/lib/mfext/circus_hooks.py: circus_hooks.py
	cp -f $< $@

$(PREFIX)/lib/mfext/mflog_addon.py: mflog_addon.py
	cp -f $< $@

$(PREFIX)/lib/mfext/conf_monitor.py: conf_monitor.py
	cp -f $< $@

$(PREFIX)/lib/mfext/circus.py: circus.py
	cp -f $< $@
