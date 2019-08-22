#!/usr/bin/env python3

import yaml
import os
import glob
import argparse
import sys
from unidecode import unidecode

DESCRIPTION = "build a MD doc file about metwork components of the given layer"
parser = argparse.ArgumentParser(description=DESCRIPTION)
parser.add_argument("--not-sphinx", action="store_true",
                    help='not sphinx rendering')
parser.add_argument("LAYER_HOME", help='a layer home')

args = parser.parse_args()
layer_home = args.LAYER_HOME
if not os.path.isdir(layer_home):
    print("ERROR: %s must be a directory", file=sys.stderr)
    sys.exit(1)

yaml_files = glob.glob("%s/share/metwork_packages/*.yaml" % layer_home)
if len(yaml_files) == 0:
    sys.exit(0)

if args.not_sphinx:
    print("Name | Version | Description | Home Page")
    print("-----|---------|-------------|----------")
else:
    print("Name | Version | Description | Home Page| |")
    print("-----|---------|-------------|----------|-|")


def flter(value):
    value = value.replace('|', ' ')
    if value is None:
        return "Unknown"
    try:
        return unidecode(value)
    except Exception:
        return unidecode(str(value))


def is_empty_or_unknown(str_to_check):
    return (str_to_check is None) or (str_to_check == '') or \
        (str_to_check.lower() == 'unknown')


for fpath in sorted(yaml_files):
    print("Reading %s..." % fpath, file=sys.stderr)
    with open(fpath, 'r', encoding="utf-8") as f:
        raw_content = f.read()
        y = yaml.load(unidecode(raw_content))
        name = flter(y['name'])
        version = flter(y['version'])
        website = flter(y['website'])
        # If website is 'empty', we assume package is a Python package
        # without website info
        # ('pip show' doesn't retrun anything about website)
        if is_empty_or_unknown(website):
            website = 'https://pypi.org/project/{}'.format(name)

        name_with_link = "[{}]({})".format(name, website)

        if args.not_sphinx:
            print("%s | %s | %s | %s" %
                  (name_with_link, version,
                   flter(y['description']),
                   website))
        else:
            print("%s | %s | %s | %s | %s" %
                  (name_with_link, version,
                   flter(y['description']),
                   website,
                   ".. index:: {}-{} package".format(name, version)))
print()
if len(yaml_files) == 1:
    print("*(1 component)*")
else:
    print("*(%i components)*" % len(yaml_files))
