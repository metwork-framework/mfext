#!/usr/bin/env python3

import sys
import os
import argparse
from mfplugin.manager import PluginsManager
from mfplugin.utils import NotInstalledPlugin
from mfutil.cli import echo_bold
from mflog import get_logger

HOME = os.environ['MFMODULE_HOME']
MFMODULE_LOWERCASE = os.environ['MFMODULE_LOWERCASE']
MFMODULE_RUNTIME_HOME = os.environ['MFMODULE_RUNTIME_HOME']
DESCRIPTION = "create a plugin configuration override file under " \
    "MFMODULE_RUNTIME_HOME/config"
LOGGER = get_logger("_prepare_plugin_config.py")


def has_an_interesting_line(path):
    try:
        with open(path, "r") as f:
            lines = f.readlines()
    except Exception as e:
        LOGGER.warning("can't read %s with exception: %s => giving up" %
                       (path, e))
        sys.exit(1)
    for line in lines:
        tmp = line.strip()
        if len(tmp) == 0:
            continue
        first = tmp[0]
        if first in ('[', '#'):
            continue
        return True
    return False


if __name__ == '__main__':

    parser = argparse.ArgumentParser(description=DESCRIPTION)
    parser.add_argument("PLUGIN_NAME", help="plugin name")
    args = parser.parse_args()

    manager = PluginsManager()
    try:
        plugin = manager.get_plugin(args.PLUGIN_NAME)
    except NotInstalledPlugin:
        echo_bold("ERROR: not installed plugin: " % args.PLUGIN_NAME)
        sys.exit(1)

    if plugin.is_dev_linked:
        sys.exit(0)

    target = "%s/config/plugins/%s.ini" % (MFMODULE_RUNTIME_HOME,
                                           args.PLUGIN_NAME)

    if os.path.exists(target):
        if not has_an_interesting_line(target):
            # There is a configuration file but nothing has been changed
            # so we can unlink it!
            try:
                os.unlink(target)
            except Exception as e:
                LOGGER.warning("can't unlink: %s with message: %s" %
                               (target, e))
        else:
            # We prefer to keep it as there are some changes in it!
            pass
