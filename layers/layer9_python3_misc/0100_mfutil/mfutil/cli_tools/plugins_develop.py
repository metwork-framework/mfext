#!/usr/bin/env python3

import argparse
import sys
from mfutil.plugins import develop_plugin, \
    MFUtilPluginAlreadyInstalled, is_dangerous_plugin
from mfutil.cli import echo_ok, echo_running, echo_nok

DESCRIPTION = "develop a plugin from a directory"


def main():
    arg_parser = argparse.ArgumentParser(description=DESCRIPTION)
    arg_parser.add_argument("--plugin-path", default=".",
                            help="plugin directory path")
    arg_parser.add_argument("name",
                            help="plugin name")
    args = arg_parser.parse_args()
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
