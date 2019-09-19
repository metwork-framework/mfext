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

def is_empty_or_unknown(str_to_check):
    return (str_to_check is None) or (str_to_check == '') or (str_to_check.lower() == 'unknown')

<<<<<<< HEAD
for fpath in sorted(yaml_files):
    print("Reading %s..." % fpath, file=sys.stderr)
=======
count = 0
for tmp in sorted(yamls):
    fpath = tmp[1]
>>>>>>> 266d46f... feat: introduce components utility
    with open(fpath, 'r', encoding="utf-8") as f:
        raw_content = f.read()
        y = yaml.load(unidecode(raw_content))
        name = flter(y['name'])
        version = flter(y['version'])
        website = flter(y['website'])
        # If website is 'empty', we assume package is a Python package without website info
        # ('pip show' doesn't retrun anything about website)
        if is_empty_or_unknown(website):
            website = 'https://pypi.org/project/{}'.format(name)

        name_with_link = "[{}]({})".format(name, website)

<<<<<<< HEAD
        print("%s | %s | %s | %s | %s" % (name_with_link, version,
                                         flter(y['description']),
                                         website,
                                         ".. index:: {}-{} package".format(name, version)))
=======
        if all_mode:
            lhome = fpath.split('/share/metwork_packages/')[0]
            with open("%s/.layerapi2_label" % lhome, 'r') as g:
                llabel = g.read().strip()
            addon = None
            try:
                with open("%s/.mfextaddon" % lhome, "r") as h:
                    addon = h.read().strip()
            except FileNotFoundError:
                pass
            if ADDON_NAME:
                if addon != ADDON_NAME:
                    continue
            else:
                if all_mode and addon:
                    continue
            lname = llabel.split('@')[0]
            if args.not_sphinx:
                description = lname
            else:
                description = ":ref:`%s <layer_%s>`" % (lname, lname)
        else:
            description = flter(y['description'])
        count = count + 1
        if args.not_sphinx:
            print("| %s | %s | %s |" %
                  (name_with_link, version,
                   description))
        else:
            if all_mode:
                index = version
            else:
                index = ":index:`{} <single: {} package>`".format(version,
                                                                  name)
            print("| %s | %s | %s |" %
                  (name_with_link, index, description))
>>>>>>> 266d46f... feat: introduce components utility
print()
if len(yaml_files) == 1:
    print("*(1 package)*")
else:
    print("*(%i packages)*" % len(yaml_files))
