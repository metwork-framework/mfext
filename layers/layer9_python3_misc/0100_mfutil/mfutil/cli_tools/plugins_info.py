#!/usr/bin/env python3

import argparse
import sys
from mfutil.plugins import get_plugin_info

DESCRIPTION = "get some information about a plugin"


def main():
    arg_parser = argparse.ArgumentParser(description=DESCRIPTION)
    arg_parser.add_argument("name_or_filepath", type=str,
                            help="installed plugin name (without version) or "
                            "full plugin filepath")
    arg_parser.add_argument("--just-home", action="store_true",
                            help="if set, just return plugin home")
    arg_parser.add_argument("--plugins-base-dir", type=str, default=None,
                            help="can be use to set an alternate "
                            "plugins-base-dir, if not set the value of "
                            "MFMODULE_PLUGINS_BASE_DIR env var is used (or a "
                            "hardcoded standard value).")
    args = arg_parser.parse_args()

    infos = get_plugin_info(args.name_or_filepath,
                            plugins_base_dir=args.plugins_base_dir)
    if infos is None:
        sys.exit(1)
    if args.just_home:
        print(infos['home'])
        sys.exit(0)

    print("Metadata:")
    print()
    print(infos['raw_metadata_output'])
    print()
    if "home" in infos:
        print("Installation home: %s" % infos['home'])
        print()
    print("List of files:")
    print()
    print(infos['raw_files_output'])


if __name__ == '__main__':
    main()
