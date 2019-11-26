#!/usr/bin/env python

import os
import glob
import sys
import logging
from mfutil.cli import echo_running, echo_ok
from mfutil.plugins import get_plugin_hash, get_plugin_info, install_plugin, \
    uninstall_plugin

MFMODULE = os.environ['MFMODULE']
MFMODULE_RUNTIME_HOME = os.environ['MFMODULE_RUNTIME_HOME']
MFMODULE_HOME = os.environ['MFMODULE_HOME']
EXTERNAL_PLUGINS_PATH = \
    "/etc/metwork.config.d/%s/external_plugins" % MFMODULE.lower()


def i_plugin(typ, name, fil):
    echo_running("- Installing %s plugin: %s..." % (typ, name))
    install_plugin(fil)
    echo_ok()


def u_plugin(typ, name, fil):
    echo_running("- Updating %s plugin: %s..." % (typ, name))
    uninstall_plugin(name)
    install_plugin(fil)
    echo_ok()


internal_plugins_to_check = []
for key, value in os.environ.items():
    begin = "%s_INTERNAL_PLUGINS_INSTALL_" % MFMODULE
    if key.startswith(begin):
        if value.strip() == "1":
            internal_plugins_to_check.append(key.replace(begin, "").lower())
external_plugins_to_check = []
for fil in glob.glob("%s/*.plugin" % EXTERNAL_PLUGINS_PATH):
    h = get_plugin_hash(fil, mode="file")
    if h:
        external_plugins_to_check.append(fil)

for plugin in internal_plugins_to_check:
    installed_hash = get_plugin_hash(plugin, mode="name")
    candidates = sorted(glob.glob("%s/share/plugins/%s-*.plugin" %
                                  (MFMODULE_HOME, plugin)),
                        key=os.path.getmtime)
    if len(candidates) == 0:
        logging.critical("can't find an installation file for plugin %s "
                         "in %s/share/plugins/" % (plugin, MFMODULE_HOME))
        sys.exit(1)
    selected_file = candidates[-1]
    selected_hash = get_plugin_hash(selected_file, mode="file")
    if not selected_hash:
        logging.critical("the selected file: %s for the plugin %s is not "
                         "correct" % (selected_file, plugin))
        sys.exit(1)
    if installed_hash is None:
        # not installed
        i_plugin("internal", plugin, selected_file)
    else:
        if selected_hash != installed_hash:
            installed_infos = get_plugin_info(plugin, mode="name")
            if installed_infos['metadatas']['release'] == "dev_link":
                continue
            # to update
            u_plugin("internal", plugin, selected_file)

for selected_file in external_plugins_to_check:
    infos = get_plugin_info(selected_file, mode="file")
    if not infos:
        continue
    name = infos['metadatas']['name']
    selected_hash = get_plugin_hash(selected_file, mode="file")
    installed_hash = get_plugin_hash(name, mode="name")
    if installed_hash is None:
        # not installed
        i_plugin("external", name, selected_file)
        pass
    else:
        if installed_hash != selected_hash:
            installed_infos = get_plugin_info(name, mode="name")
            if installed_infos['metadatas']['release'] == "dev_link":
                continue
            # to update
            u_plugin("external", name, selected_file)
