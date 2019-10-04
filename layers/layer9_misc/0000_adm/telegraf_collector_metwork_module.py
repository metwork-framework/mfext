#!/usr/bin/env python

# inspired from
# https://github.com/monitoring-tools/telegraf-plugins/tree/master/netstat

import os
import time
import json
import fnmatch
from telegraf_unixsocket_client import TelegrafUnixSocketClient
from mflog import getLogger
from mfutil import BashWrapper

MFMODULE_RUNTIME_HOME = os.environ["MFMODULE_RUNTIME_HOME"]
SOCKET_PATH = os.path.join(MFMODULE_RUNTIME_HOME, "var", "telegraf.socket")
LOGGER = getLogger("telegraf_collector_metwork_module")
MFMODULE = os.environ['MFMODULE']
CMD = "list_metwork_processes.py --output-format=json --include-current-family"
MONITORING_CMDLINE_PATTERNS = ['*telegraf*', '*list_metwork_processes*',
                               '*jsonlog2elasticsearch*']
IS_MONITORING_MODULE = (MFMODULE in ['MFSYSMON', 'MFADMIN'])


def is_cmdline_monitoring(cmdline):
    if IS_MONITORING_MODULE:
        return True
    for pattern in MONITORING_CMDLINE_PATTERNS:
        if fnmatch.fnmatch(cmdline, pattern):
            return True
    return False


def get_stats():
    stats = {}
    results = BashWrapper(CMD)
    if not results:
        LOGGER.warning("can't execute %s: %s" % (CMD, results))
        return None
    try:
        processes = json.loads(results.stdout)
    except Exception:
        LOGGER.warning("can't parse %s output as JSON" % CMD)
        return None
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
                stats[plugin][key] = sum([x[key] for x in processes
                                if x['plugin'] == search_plugin and
                                not is_cmdline_monitoring(x['cmdline'])])
            else:
                stats[plugin][key] = sum([x[key] for x in processes
                                if x['plugin'] == search_plugin and
                                is_cmdline_monitoring(x['cmdline'])])
    return stats


while True:
    LOGGER.debug("waiting 10s...")
    time.sleep(10)
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
    client.close()
