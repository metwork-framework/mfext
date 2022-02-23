#!/usr/bin/env python3

import yaml
import os
import glob
import argparse
import sys
from unidecode import unidecode

DESCRIPTION = "build a MD doc file about metwork components of the given layer"
MFMODULE_HOME = os.environ['MFMODULE_HOME']
parser = argparse.ArgumentParser(description=DESCRIPTION)
parser.add_argument("LAYER_HOME", help='a layer home (if set to ALL, '
                    'build for all layers)')

args = parser.parse_args()
layer_home = args.LAYER_HOME
if layer_home == "ALL":
    all_mode = True
else:
    all_mode = False
    if not os.path.isdir(layer_home):
        print("ERROR: %s must be a directory", file=sys.stderr)
        sys.exit(1)

if all_mode:
    yaml_files = glob.glob("%s/opt/*/share/metwork_packages/*.yaml" %
                           MFMODULE_HOME)
    yaml_files = yaml_files + glob.glob("%s/share/metwork_packages/*.yaml" %
                                        MFMODULE_HOME)
else:
    yaml_files = glob.glob("%s/share/metwork_packages/*.yaml" % layer_home)
if len(yaml_files) == 0:
    sys.exit(0)

yamls = []
for yaml_file in yaml_files:
    yamls.append((os.path.basename(yaml_file), yaml_file))


if all_mode:
    print("| Name | Version | Layer |")
else:
    print("| Name | Version | Description |")
print("| --- | --- | --- |")

ADDON_NAME = os.environ.get('MFEXT_ADDON_NAME', None)


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


count = 0
for tmp in sorted(yamls, key=lambda x: (x[0].lower(), x[1])):
    fpath = tmp[1]
    with open(fpath, 'r', encoding="utf-8") as f:
        raw_content = f.read()
        y = yaml.load(unidecode(raw_content), Loader=yaml.FullLoader)
        name = flter(y['name'])
        version = flter(y['version'])
        website = flter(y['website'])
        # If website is 'empty', we assume package is a Python package
        # without website info
        # ('pip show' doesn't retrun anything about website)
        if is_empty_or_unknown(website):
            website = 'https://pypi.org/project/{}'.format(name)

        name_with_link = "[{}]({})".format(name, website)

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
            description = lname
        else:
            description = flter(y['description'])
        count = count + 1
        print("| %s | %s | %s |" %
              (name_with_link, version,
               description))
print()
if count == 0:
    print("*(0 component)*")
elif count == 1:
    print("*(1 component)*")
else:
    print("*(%i components)*" % count)
