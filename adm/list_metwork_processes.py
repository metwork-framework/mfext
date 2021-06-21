#!/usr/bin/env python3

import sys
import argparse
import json

import mfext.metwork_processes as mfp


argparser = argparse.ArgumentParser(description="list metwork processes")
argparser.add_argument("--pids-only", action="store_true",
                       help="show only pids")
argparser.add_argument("--include-current-family", action="store_true",
                       help="include current process family")
argparser.add_argument("--output-format", default="text",
                       help="output format (text (default) or json")
args = argparser.parse_args()
if args.output_format not in ("text", "json"):
    print("ERROR: bad output format")
    sys.exit(1)

if args.include_current_family:
    processes = mfp.get_processes_dict(exclude_same_family=None,
                                       pids_only=args.pids_only)
else:
    processes = mfp.get_processes_dict(pids_only=args.pids_only)

if args.pids_only:
    if args.output_format == 'json':
        print(json.dumps([x['pid'] for x in processes], indent=4))
        sys.exit(0)
    else:
        for proc in processes:
            print(proc['pid'])
        sys.exit(0)

if args.output_format == 'json':
    print(json.dumps(processes, indent=4))
    sys.exit(0)

processes_count = 0
for proc in processes:
    print("- Process %s (pid=%i):" % (proc["name"], proc["pid"]))
    print("    - cmdline          : %s" % proc["cmdline"])
    print("    - num fdsi         : %i" % proc["num_fds"])
    print("    - num threads      : %i" % proc["num_threads"])
    print("    - cpu_percent      : %f" % proc["cpu_percent"])
    print("    - mem_percent (pss): %f" % proc["mem_percent"])
    print("    - plugin           : %s" % proc["plugin"])
    processes_count = processes_count + 1
print()
print("Total: %i processes" % processes_count)
sys.exit(0)
