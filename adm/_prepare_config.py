#!/usr/bin/env python

from __future__ import print_function
import os


HOME = os.environ['MFMODULE_HOME']

if __name__ == '__main__':

    conf_file = "%s/config/config.ini" % HOME
    with open(conf_file, "r") as f:
        lines = f.readlines()

    print("# THIS FILE OVERRIDES %s CONFIGURATION FILE" % conf_file)
    print("# DON'T CHANGE ANYTHING IN %s FILE" % conf_file)
    print("# DON'T REMOVE THE INCLUDE_config.ini LINE BELLOW")
    print("# => YOU CAN JUST SET THE KEY YOU WANT TO OVERRIDE "
          "BY REMOVING COMMENT")
    print("#    BEFORE THE KEY NAME AND BY CHANGING ITS VALUE HERE")
    print("[INCLUDE_config.ini]")
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
