#!/usr/bin/env python

# inspired from
# https://github.com/monitoring-tools/telegraf-plugins/tree/master/netstat

import os
import sys
import time
import fnmatch
from telegraf_unixsocket_client import TelegrafUnixSocketClient
from mflog import getLogger
import mfplugin.compat
import distro
import mfext.metwork_processes as mfp

MFMODULE_RUNTIME_HOME = os.environ["MFMODULE_RUNTIME_HOME"]
SOCKET_PATH = os.path.join(MFMODULE_RUNTIME_HOME, "var", "telegraf.socket")
LOGGER = getLogger("telegraf_collector_metwork_module")
MFEXT_VERSION = os.environ["MFEXT_VERSION"]
MFMODULE_VERSION = os.environ["MFMODULE_VERSION"]
MFMODULE = os.environ['MFMODULE']
MONITORING_CMDLINE_PATTERNS = ['*telegraf*', '*list_metwork_processes*',
                               '*vector*']
IS_MONITORING_MODULE = (MFMODULE in ['MFSYSMON', 'MFADMIN'])
IS_LINUX = sys.platform.startswith("linux")
OS_NAME = distro.name(pretty=True) if IS_LINUX else "unknown"


def is_cmdline_monitoring(cmdline):
    if IS_MONITORING_MODULE:
        return True
    for pattern in MONITORING_CMDLINE_PATTERNS:
        if fnmatch.fnmatch(cmdline, pattern):
            return True
    return False


def get_stats():
    stats = {}
    processes = mfp.get_processes_dict(exclude_same_family=None,
                                       pids_only=False)
    plugins = set([x['plugin'] for x in processes if x['plugin'] != ''])
    plugins.add('#monitoring#')
    if not IS_MONITORING_MODULE:
        plugins.add('#core#')
    for plugin in plugins:
        if plugin not in stats:
            stats[plugin] = {}
        for key in ('mem_percent', 'num_threads', 'cpu_percent', 'num_fds'):
            search_plugin = plugin if not plugin.startswith('#') else ''
            if plugin != '#monitoring#':
                stats[plugin][key] = \
                    sum([x[key] for x in processes
                         if x['plugin'] == search_plugin and
                         not is_cmdline_monitoring(x['cmdline'])])
            else:
                stats[plugin][key] = \
                    sum([x[key] for x in processes
                         if x['plugin'] == search_plugin and
                         is_cmdline_monitoring(x['cmdline'])])
    return stats


def get_versions():
    return {
        "mfext_version": MFEXT_VERSION,
        "version": MFMODULE_VERSION,
        "os_name": OS_NAME
    }


def get_plugins():
    plugins = {}
    if MFMODULE in ("MFSERV", "MFDATA", "MFBASE"):
        try:
            plugins = mfplugin.compat.get_installed_plugins()
        except Exception:
            pass
    return plugins


def get_status():
    status = "unknown"
    status_code = 0
    try:
        with open("%s/var/status" % MFMODULE_RUNTIME_HOME, "r") as f:
            status = f.read().strip().lower()
        if status in ('running',):
            status_code = 2
        elif status in ('error', 'unknown'):
            status_code = 0
        else:
            status_code = 1
    except Exception:
        pass
    return {"status": status, "status_code": status_code}


while True:
    LOGGER.debug("waiting 60s...")
    time.sleep(60)
    client = TelegrafUnixSocketClient(SOCKET_PATH)
    try:
        client.connect()
    except Exception:
        LOGGER.warning("can't connect to %s, wait 10s and try again...",
                       SOCKET_PATH)
        continue
    stats = get_stats()
    if stats:
        for plugin, fields_dict in stats.items():
            msg = client.send_measurement("metwork_module", fields_dict,
                                          extra_tags={"plugin": plugin})
            LOGGER.debug("sended msg: %s" % msg)
    versions = get_versions()
    status = get_status()
    msg = client.send_measurement(
        "metwork_version", {"version": versions["mfext_version"],
                            "status": "ok",
                            "os_name": versions["os_name"]},
        extra_tags={"bypassbasicstats": "1", "modname": "mfext"})
    LOGGER.debug("sended msg: %s" % msg)
    msg = client.send_measurement(
        "metwork_version", {"version": versions["version"],
                            "status": status["status"],
                            "os_name": versions["os_name"],
                            "status_code": status["status_code"]},
        extra_tags={"bypassbasicstats": "1", "modname": MFMODULE.lower()})
    LOGGER.debug("sended msg: %s" % msg)
    plugins = get_plugins()
    for plugin in plugins:
        tags = {"plugin_name": plugin["name"],
                "bypassbasicstats": "1"}
        msg = client.send_measurement("metwork_plugin",
                                      {"version": plugin["version"],
                                       "release": plugin["release"]},
                                      extra_tags=tags)
        LOGGER.debug("sended msg: %s" % msg)
    client.close()
