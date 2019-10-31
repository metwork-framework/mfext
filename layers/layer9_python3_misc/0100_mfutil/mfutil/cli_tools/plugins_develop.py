#!/usr/bin/env python3

import os
import argparse
import sys
from mfutil.plugins import develop_plugin, \
    MFUtilPluginAlreadyInstalled, is_dangerous_plugin, \
    is_plugins_base_initialized
from mfutil.cli import echo_ok, echo_running, echo_nok, echo_bold

DESCRIPTION = "develop a plugin from a directory"
MFMODULE_LOWERCASE = os.environ['MFMODULE_LOWERCASE']


def main():
    arg_parser = argparse.ArgumentParser(description=DESCRIPTION)
    arg_parser.add_argument("--plugin-path", default=".",
                            help="plugin directory path")
    arg_parser.add_argument("name",
                            help="plugin name")
    args = arg_parser.parse_args()
    if not is_plugins_base_initialized():
        echo_bold("ERROR: the module is not initialized")
        echo_bold("       => start it once before installing your plugin")
        print()
        print("hint: you can use %s.start to do that" % MFMODULE_LOWERCASE)
        print()
        sys.exit(3)
    echo_running("- Devlinking plugin %s..." % args.name)
    try:
        develop_plugin(args.plugin_path, args.name)
    except MFUtilPluginAlreadyInstalled:
        echo_nok("already installed")
        sys.exit(1)
    echo_ok()
    is_dangerous_plugin(args.name)


if __name__ == '__main__':
    main()
