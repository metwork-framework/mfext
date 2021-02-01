#!/usr/bin/env python3

import sys
import argparse
from mfext.circus import MetWorkCircusClient

parser = argparse.ArgumentParser()
parser.add_argument('names', metavar='NAME', type=str, nargs='+',
                    help='watcher names to wait for start')
parser.add_argument('--timeout', help="timeout of the wait", default=20)
args = parser.parse_args()

client = MetWorkCircusClient()
if not client.check():
    sys.exit(0)

for name in args.names:
    client.wait_watcher_started(name=name, timeout=args.timeout)
