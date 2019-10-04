#!/usr/bin/env python3

import argparse
import sys
from mfutil.plugins import build_plugin, \
    MFUtilPluginCantBuild
from mfutil.cli import echo_ok, echo_running, echo_nok, echo_bold

DESCRIPTION = "make a plugin from the current directory"


def main():
    arg_parser = argparse.ArgumentParser(description=DESCRIPTION)
    arg_parser.add_argument("--plugin-path", default=".",
                            help="plugin directory path")
    arg_parser.add_argument("--show-plugin-path", action="store_true",
                            default=False,
                            help="show the generated plugin path")
    args = arg_parser.parse_args()
    echo_running("- Building plugin...")
    try:
        path = build_plugin(args.plugin_path)
    except MFUtilPluginCantBuild as e:
        echo_nok()
        print(e)
        sys.exit(1)
    echo_ok()
    if args.show_plugin_path:
        echo_bold("plugins is ready at %s" % path)


if __name__ == '__main__':
    main()
