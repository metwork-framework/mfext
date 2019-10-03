#!/usr/bin/env python3

import os
import psutil
import sys
import argparse

from mflog import getLogger

LOG = getLogger('kill_zombies_nginx_workers')
USER = os.environ.get('MFMODULE_RUNTIME_USER', None)
if USER is None:
    LOG.critical("can't read MFMODULE_RUNTIME_USER env var")
    sys.exit(1)
MFMODULE_RUNTIME_HOME = os.environ.get('MFMODULE_RUNTIME_HOME', None)
if MFMODULE_RUNTIME_HOME is None:
    LOG.critical("can't read MFMODULE_RUNTIME_HOME env var")
    sys.exit(1)


def get_pids():
    pids = []
    for proc in psutil.process_iter():
        try:
            if proc.username() != USER:
                continue
            if proc.ppid() != 1:
                continue
            cmdline = " ".join(proc.cmdline())
            if "nginx: worker process" not in cmdline:
                continue
            cwd = ""
            try:
                cwd = proc.cwd()
            except Exception:
                # we can have some exceptions here in some edge cases
                LOG.debug("exception catched #1")
                pass
            if not cwd.startswith(MFMODULE_RUNTIME_HOME):
                continue
            pids.append(proc.pid)
        except Exception:
            # we can have some exceptions here in some edge cases
            LOG.debug("exception catched #2")
            pass
    return pids


argparser = argparse.ArgumentParser(description="find zombies nginx workers "
                                    "for the current user/module")
args = argparser.parse_args()

pids = []
try:
    pids = get_pids()
except Exception:
    # maybe we can have some exceptions here in some edge cases
    # we don't want any false positive
    LOG.debug("exception catched #3")
    pass

for pid in pids:
    print(pid)

if len(pids) > 0:
    sys.exit(1)
else:
    sys.exit(0)
