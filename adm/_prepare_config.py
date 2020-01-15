#!/usr/bin/env python

from __future__ import print_function
import os


HOME = os.environ['MFMODULE_HOME']
MFMODULE = os.environ['MFMODULE']

if __name__ == '__main__':

    conf_file = "%s/config/config.ini" % HOME
    with open(conf_file, "r") as f:
        lines = f.readlines()

    print("# THIS FILE OVERRIDES %s CONFIGURATION FILE" % conf_file)
    print("# DON'T CHANGE ANYTHING IN %s FILE, NEVER" % conf_file)
    print("#")
    print("# => to set a new value for a key, just uncomment it in the "
          "     current file and change its value")
    print("#")
    print("# Note: this file itself can be overriden by: ")
    print("#       /etc/metwork.config.d/%s/config.ini" % MFMODULE)
    print("#       (if exists)")
    print("# Read the configuration head in reference documentation for "
          "details")
    print("")
    for line in lines:
        tmp = line.strip()
        if len(tmp) == 0:
            print(tmp)
            continue
        first = tmp[0]
        if first in ('[', '#'):
            print(tmp)
            continue
        print("# %s" % tmp)
