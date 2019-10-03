#!/usr/bin/env python3

import argparse
import sys
import json
from mfutil.plugins import get_installed_plugins
from terminaltables import SingleTable

DESCRIPTION = "get the installed plugins list"


def main():
    arg_parser = argparse.ArgumentParser(description=DESCRIPTION)
    arg_parser.add_argument("--raw", action="store_true", help="raw mode")
    arg_parser.add_argument("--json", action="store_true", help="json mode "
                            "(not compatible with raw mode)")
    arg_parser.add_argument("--plugins-base-dir", type=str, default=None,
                            help="can be use to set an alternate "
                            "plugins-base-dir, if not set the value of "
                            "MFMODULE_PLUGINS_BASE_DIR env var is used (or a "
                            "hardcoded standard value).")
    args = arg_parser.parse_args()
    if args.json and args.raw:
        print("ERROR: json and raw options are mutually exclusives")
        sys.exit(1)
    plugins = get_installed_plugins(plugins_base_dir=args.plugins_base_dir)
    json_output = []
    table_data = []
    table_data.append(["Name", "Version", "Release", "Home"])
    for plugin in plugins:
        name = plugin['name']
        release = plugin['release']
        version = plugin['version']
        home = plugin['home']
        if args.raw:
            print("%s~~~%s~~~%s~~~%s" % (name, version, release, home))
        elif args.json:
            json_output.append({
                "name": name,
                "release": release,
                "version": version,
                "home": home
            })
        else:
            table_data.append([name, version, release, home])
    if not args.raw and not args.json:
        t = SingleTable(title="Installed plugins (%i)" % len(plugins),
                        table_data=table_data)
        print(t.table)
    elif args.json:
        print(json.dumps(json_output, indent=4))


if __name__ == '__main__':
    main()
