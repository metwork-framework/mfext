#!/usr/bin/env python3

import argparse
import sys
from mfutil.plugins import validate_plugin_name

DESCRIPTION = "validate a plugin name"


def main():
    arg_parser = argparse.ArgumentParser(description=DESCRIPTION)
    arg_parser.add_argument("plugin_name", type=str,
                            help="plugin name candidate")
    args = arg_parser.parse_args()

    (b, msg) = validate_plugin_name(args.plugin_name)
    if b is True:
        print("OK")
        sys.exit(0)
    print("ERROR: %s" % msg)
    sys.exit(1)


if __name__ == '__main__':
    main()
