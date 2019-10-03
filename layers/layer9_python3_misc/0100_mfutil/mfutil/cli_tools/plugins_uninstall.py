#!/usr/bin/env python3

import argparse
import sys
from mfutil.plugins import uninstall_plugin, \
    MFUtilPluginNotInstalled, MFUtilPluginCantUninstall, inside_a_plugin_env
from mfutil.cli import echo_running, echo_nok, echo_ok

DESCRIPTION = "uninstall a plugin"


def main():
    arg_parser = argparse.ArgumentParser(description=DESCRIPTION)
    arg_parser.add_argument("name", type=str,
                            help="plugin name")
    arg_parser.add_argument("--force", help="ignore some errors",
                            action="store_true")
    arg_parser.add_argument("--plugins-base-dir", type=str, default=None,
                            help="can be use to set an alternate "
                            "plugins-base-dir, if not set the value of "
                            "MFMODULE_PLUGINS_BASE_DIR env var is used (or a "
                            "hardcoded standard value).")
    args = arg_parser.parse_args()
    name = args.name
    if inside_a_plugin_env():
        print("ERROR: Don't use plugins.install/uninstall inside a plugin_env")
        sys.exit(1)
    echo_running("- Uninstalling plugin %s..." % name)
    try:
        uninstall_plugin(name, ignore_errors=args.force,
                         plugins_base_dir=args.plugins_base_dir)
    except MFUtilPluginNotInstalled:
        echo_nok("not installed")
        sys.exit(1)
    except MFUtilPluginCantUninstall as e:
        echo_nok()
        print(e)
        sys.exit(2)
    echo_ok()


if __name__ == '__main__':
    main()
