#!/usr/bin/env python3

import argparse
import sys
from mfutil.plugins import init_plugins_base, is_plugins_base_initialized, \
    MFUtilPluginCantInit
from mfutil.cli import echo_ok, echo_running, echo_nok

DESCRIPTION = "init the plugins base (dangerous)"


def main():
    arg_parser = argparse.ArgumentParser(description=DESCRIPTION)
    arg_parser.add_argument("--plugins-base-dir", type=str, default=None,
                            help="can be use to set an alternate "
                            "plugins-base-dir, if not set the value of "
                            "MFMODULE_PLUGINS_BASE_DIR env var is used (or a "
                            "hardcoded standard value).")
    args = arg_parser.parse_args()
    echo_running("- Creating plugins base...")
    try:
        init_plugins_base(args.plugins_base_dir)
    except MFUtilPluginCantInit as e:
        echo_nok()
        print(e)
        sys.exit(1)
    if not is_plugins_base_initialized():
        echo_nok()
        sys.exit(1)
    echo_ok()


if __name__ == '__main__':
    main()
