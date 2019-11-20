#!/usr/bin/env python3

import psutil
import sys
import argparse
import json

from mfutil import kill_process_and_children, BashWrapper
from mflog import getLogger

LOG = getLogger('kill_remaining_processes')


def get_processes_to_kill():
    x = BashWrapper("list_metwork_processes.py --pids-only "
                    "--output-format=json")
    if not x:
        LOG.warning("can't execute: %s" % x)
        sys.exit(1)
    try:
        pids = json.loads(x.stdout)
    except Exception:
        LOG.warning("bad output: %s" % x)
        sys.exit(1)
    return pids


argparser = argparse.ArgumentParser(description="kill remaining non-terminal "
                                    "processes after a module stop")
silent_doc = "silent mode: return only the number of processes killed and " \
    "the number of remaining processes"
argparser.add_argument("--silent", action="store_true", help=silent_doc)
args = argparser.parse_args()
processes_to_kill = get_processes_to_kill()
first_count = len(processes_to_kill)
for pid in processes_to_kill:
    if not args.silent:
        try:
            proc = psutil.Process(pid)
            LOG.info("killing remaining process (and children): "
                     "pid:%i, cmdline: %s" % (proc.pid,
                                              " ".join(proc.cmdline())))
        except Exception:
            # we can have some exceptions here is some edge cases
            pass
    kill_process_and_children(pid)

processes_to_kill = get_processes_to_kill()
second_count = len(processes_to_kill)
for pid in processes_to_kill:
    if not args.silent:
        try:
            proc = psutil.Process(pid)
            LOG.warning("remaining process not killed: "
                        "pid:%i, cmdline: %s" % (proc.pid,
                                                 " ".join(proc.cmdline())))
        except Exception:
            # we can have some exceptions here is some edge cases
            pass

if args.silent:
    print("%i,%i" % (first_count, second_count))
if len(processes_to_kill) > 0:
    sys.exit(1)
sys.exit(0)
