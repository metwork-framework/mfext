#!/usr/bin/env python3

import yaml
import os
import glob
import argparse
import sys
from unidecode import unidecode

DESCRIPTION = "build a MD doc file about metwork packages of the given layer"
parser = argparse.ArgumentParser(description=DESCRIPTION)
parser.add_argument("LAYER_HOME", help='a layer home')

args = parser.parse_args()
layer_home = args.LAYER_HOME
if not os.path.isdir(layer_home):
    print("ERROR: %s must be a directory", file=sys.stderr)
    sys.exit(1)

yaml_files = glob.glob("%s/share/metwork_packages/*.yaml" % layer_home)
if len(yaml_files) == 0:
    sys.exit(0)

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


for fpath in sorted(yaml_files):
    print("Reading %s..." % fpath, file=sys.stderr)
    with open(fpath, 'r', encoding="utf-8") as f:
        raw_content = f.read()
        y = yaml.load(unidecode(raw_content))
        website = flter(y['website'])
        name_with_link = flter(y['name'])
        if not ((website is None) or (website == '')):
            name_with_link = "[{}]({})".format(name_with_link, website)

        print("%s | %s | %s | %s | %s" % (name_with_link, flter(y['version']),
                                         flter(y['description']),
                                         flter(y['website']),
                                         ".. index:: {} package".format(flter(y['name']))))
print()
if len(yaml_files) == 1:
    print("*(1 package)*")
else:
    print("*(%i packages)*" % len(yaml_files))
