#!/usr/bin/env python3

import datetime
import os
import sys
import time
import redis
from mfutil.cli import MFProgress

MFMODULE_RUNTIME_HOME = os.environ['MFMODULE_RUNTIME_HOME']
timeout = 20

with MFProgress() as progress:
    t = progress.add_task("- Waiting for redis to be ready...", total=timeout)
    before = datetime.datetime.now()
    after = datetime.datetime.now()
    while (after - before).total_seconds() < timeout:
        r = redis.Redis(unix_socket_path=f"{MFMODULE_RUNTIME_HOME}/var/redis.socket")
        if r.ping():
            progress.complete_task(t)
            sys.exit(0)
        time.sleep(1)
        after = datetime.datetime.now()
        delta = (after - before).total_seconds()
        progress.update(t, completed=int(delta))
    progress.complete_task_nok(t)
    sys.exit(1)
