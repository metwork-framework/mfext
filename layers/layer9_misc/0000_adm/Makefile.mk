BINS=_circus.start _circus.stop _circus.status __ini_to_env.py before_start_redis before_start_nginx after_stop_nginx port_test.sh _make_and_install_crontab.sh _uninstall_crontab.sh circus_status_watcher.sh redis_status.sh config.py metwork _prepare_config.py _make_nethard_config.py _make_circus_conf _make_crontab.sh remove_empty.sh kill_remaining_processes.py bootstrap_plugin.py bootstrap_plugin.py _make_nginx_conf bootstrap_plugin.post _circusctl _install_or_update_configured_plugins.py nginx.status find_zombies_nginx_workers.py before_start_telegraf _circus_wait_watcher_stopped.sh _circus_schedule_stop_watcher.sh _install_plugin_virtualenv plugin_wrapper _plugins.preuninstall _plugins.postinstall list_metwork_processes.py telegraf_collector_metwork_module.py _nginx.reload _circus.reload _plugins.is_dangerous _circus_wait_watcher_started.sh nginxfmt.py before_start_conf_monitor
SHARES=startup_scripts_profiles.mk plugin.mk config_subdir.mk plugin_autorestart_includes plugin_autorestart_excludes metwork.service

include ../../../adm/root.mk
include ../../simple_layer.mk

