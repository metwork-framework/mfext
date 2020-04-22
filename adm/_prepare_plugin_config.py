#!/usr/bin/env python3

import sys
import os
import argparse
from mfplugin.manager import PluginsManager
from mfplugin.utils import NotInstalledPlugin
from mfutil.cli import echo_bold
from mfutil import mkdir_p_or_die
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

    conf_file = "%s/config.ini" % plugin.home
    try:
        with open(conf_file, "r") as f:
            lines = f.readlines()
    except Exception as e:
        echo_bold("ERROR: can't read %s, exception: %s" % (conf_file, e))
        sys.exit(1)

    mkdir_p_or_die("%s/config/plugins" % MFMODULE_RUNTIME_HOME)
    target = "%s/config/plugins/%s.ini" % (MFMODULE_RUNTIME_HOME,
                                           args.PLUGIN_NAME)

    if os.path.exists(target):
        if has_an_interesting_line(target):
            # we prefer not to override
            new_target = "%s.new" % target
            LOGGER.warning("%s already exists, we prefer not to override, "
                           "new file created as: %s => please merge them "
                           "manually" % (target, new_target))
            target = new_target

    with open(target, "w") as f:
        f.write("# THIS FILE OVERRIDES %s CONFIGURATION FILE (plugin: %s)\n" %
                (conf_file, args.PLUGIN_NAME))
        f.write("# DON'T CHANGE ANYTHING IN %s FILE, NEVER\n" % conf_file)
        f.write("#\n")
        f.write("# => to set a new value for a key, "
                "just uncomment it in the \n")
        f.write("#    current file and change its value\n")
        f.write("#\n")
        f.write("# Note: this file itself can be overriden by:\n")
        f.write("#       /etc/metwork.config.d/%s/plugins/%s.ini\n" %
                (MFMODULE_LOWERCASE, args.PLUGIN_NAME))
        f.write("#       (if exists)\n")
        f.write("\n")
        f.write("\n")
        to_write = []
        for line in lines:
            tmp = line.strip()
            if len(tmp) == 0:
                to_write.append("")
                continue
            first = tmp[0]
            if first == "[":
                if tmp == "[general]":
                    to_write = []
                    continue
                f.write("%s\n" % tmp)
                to_write = []
                continue
            if first == "#":
                to_write.append(tmp)
                continue
            if first == "_":
                to_write = []
                continue
            f.write("\n".join(to_write))
            f.write("\n# %s\n" % tmp)
            to_write = []
