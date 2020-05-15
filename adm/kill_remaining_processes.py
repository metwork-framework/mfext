#!/usr/bin/env python3

import psutil
import sys
import argparse
import json

from mfutil import kill_process_and_children, BashWrapper
from mfutil.cli import MFProgress
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
debug_doc = "debug mode: show processes killed"
argparser.add_argument("--debug", action="store_true", help=debug_doc)
args = argparser.parse_args()
processes_to_kill = get_processes_to_kill()
first_count = len(processes_to_kill)
with MFProgress() as progress:
    t = progress.add_task("- Killing remainging processes (if any)...",
                          total=(first_count + 1))
    for pid in processes_to_kill:
        if args.debug:
            try:
                proc = psutil.Process(pid)
                LOG.info("killing remaining process (and children): "
                         "pid:%i, cmdline: %s" % (proc.pid,
                                                  " ".join(proc.cmdline())))
            except Exception:
                # we can have some exceptions here is some edge cases
                pass
        kill_process_and_children(pid)
        progress.update(t, advance=1)

    processes_to_kill = get_processes_to_kill()
    second_count = len(processes_to_kill)
    if second_count == 0:
        if first_count > 0:
            progress.complete_task_warning(t, "%i killed" % first_count)
        else:
            progress.complete_task(t)
    else:
        for pid in processes_to_kill:
            progress.complete_task_nok(t, "%i remaining" % second_count)
            if args.debug:
                try:
                    proc = psutil.Process(pid)
                    LOG.warning("remaining process not killed: "
                                "pid:%i, cmdline: %s" %
                                (proc.pid, " ".join(proc.cmdline())))
                except Exception:
                    # we can have some exceptions here is some edge cases
                    pass

if len(processes_to_kill) > 0:
    sys.exit(1)
sys.exit(0)
