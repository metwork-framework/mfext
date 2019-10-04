#!/usr/bin/env python3

import argparse
import sys
from mfutil.plugins import get_plugin_hash

DESCRIPTION = "get a hash of a plugin"


def main():
    arg_parser = argparse.ArgumentParser(description=DESCRIPTION)
    arg_parser.add_argument("name_or_filepath", type=str,
                            help="installed plugin name (without version) or "
                            "full plugin filepath")
    args = arg_parser.parse_args()

    hsh = get_plugin_hash(args.name_or_filepath)
    if hsh is None:
        sys.exit(1)
    print(hsh)


if __name__ == '__main__':
    main()
