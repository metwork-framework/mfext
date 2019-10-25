#!/usr/bin/env python3

import os
import argparse
import sys
from mfutil.plugins import install_plugin, get_plugin_info, \
    MFUtilPluginAlreadyInstalled, MFUtilPluginCantInstall, \
    is_dangerous_plugin, inside_a_plugin_env, is_plugins_base_initialized
from mfutil.cli import echo_running, echo_nok, echo_ok, echo_bold

DESCRIPTION = "install a plugin file"
MFMODULE_LOWERCASE = os.environ['MFMODULE_LOWERCASE']


def main():
    arg_parser = argparse.ArgumentParser(description=DESCRIPTION)
    arg_parser.add_argument("plugin_filepath", type=str,
                            help="plugin filepath")
    arg_parser.add_argument("--force", help="ignore some errors",
                            action="store_true")
    arg_parser.add_argument("--plugins-base-dir", type=str, default=None,
                            help="can be use to set an alternate "
                            "plugins-base-dir, if not set the value of "
                            "MFMODULE_PLUGINS_BASE_DIR env var is used (or a "
                            "hardcoded standard value).")
    args = arg_parser.parse_args()
    if inside_a_plugin_env():
        print("ERROR: Don't use plugins.install/uninstall inside a plugin_env")
        sys.exit(1)
    if not is_plugins_base_initialized(args.plugins_base_dir):
        echo_bold("ERROR: the module is not initialized")
        echo_bold("       => start it once before installing your plugin")
        print()
        print("hint: you can use %s.start to do that" % MFMODULE_LOWERCASE)
        print()
        sys.exit(3)
    echo_running("- Checking plugin file...")
    infos = get_plugin_info(args.plugin_filepath, mode="file",
                            plugins_base_dir=args.plugins_base_dir)
    if not infos:
        echo_nok()
        sys.exit(1)
    echo_ok()
    name = infos['metadatas']['name']
    echo_running("- Installing plugin %s..." % name)
    try:
        install_plugin(args.plugin_filepath, ignore_errors=args.force,
                       plugins_base_dir=args.plugins_base_dir)
    except MFUtilPluginAlreadyInstalled:
        echo_nok("already installed")
        sys.exit(1)
    except MFUtilPluginCantInstall as e:
        echo_nok()
        print(e)
        sys.exit(2)
    echo_ok()
    is_dangerous_plugin(name, plugins_base_dir=args.plugins_base_dir)


if __name__ == '__main__':
    main()
