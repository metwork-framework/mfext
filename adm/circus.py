#!/usr/bin/env python3

import os
import fnmatch
import datetime
import time
import mflog
from mfutil.cli import is_interactive, echo_ok, echo_warning, echo_nok, \
    echo_running
from circus.client import CircusClient
from circus.exc import CallError

LOGGER = mflog.get_logger("circus.py")


class MetWorkCircusClient(object):
    def __init__(self, timeout=10):
        self.is_interactive = is_interactive()
        self.module = os.environ["MFMODULE"]
        self.endpoint = os.environ["%s_CIRCUS_ENDPOINT" % self.module]
        self.timeout = timeout
        self.client = CircusClient(
            endpoint=self.endpoint, timeout=self.timeout
        )

    def check(self):
        if not os.path.exists(self.endpoint.replace('ipc://', '')):
            return False
        tmp = self.cmd("globaloptions")
        if tmp is None or (tmp.get('status', None) != 'ok'):
            return False
        return True

    def _cmd(self, cmd, **properties):
        reply = self.client.call({"command": cmd, "properties": properties})
        status = "nok"
        try:
            status = reply["status"]
        except Exception:
            pass
        if status != "ok":
            try:
                if "arbiter is already running" in reply['reason']:
                    return {"status": "already_running"}
            except Exception:
                pass
            return None
        return reply

    def cmd(self, cmd, **properties):
        before = datetime.datetime.now()
        while ((datetime.datetime.now() - before).total_seconds()) < 10:
            try:
                tmp = self._cmd(cmd, **properties)
            except CallError:
                return None
            if tmp is None or (tmp.get('status', None) != "already_running"):
                return tmp
            time.sleep(0.2)

    def list_watchers(self):
        tmp = self.cmd("list")
        if tmp is None:
            return None
        return tmp["watchers"]

    def list_watchers_by_plugin_pattern(self, plugin_name_pattern):
        plugin_key = self.module.lower() + "_plugin"
        watchers = self.list_watchers()
        res = []
        if watchers is None:
            return res
        for watcher in watchers:
            options = self.options(name=watcher)
            if plugin_key not in options:
                continue
            if fnmatch.fnmatch(options[plugin_key], plugin_name_pattern):
                res.append(watcher)
        return res

    def stop_watcher(self, cli_display=True, check=True, indent=0,
                     **properties):
        name = properties["name"]
        if cli_display:
            echo_running(" " * indent + "- Scheduling stop of %s" % name)
            statuses = self.statuses()
            if name not in statuses:
                echo_warning("(not found)")
                return None
            if statuses[name] == "stopped":
                echo_warning("(already stopped)")
                return "stopped"
            if statuses[name] == "stopping":
                echo_warning("(already stopping)")
                return "stopping"
        tmp = self.cmd("stop", **properties)
        status = tmp.get("status", None) if tmp is not None else None
        if cli_display:
            if not check:
                echo_ok()
            else:
                if status in ["stopping", "stopped"]:
                    echo_ok()
                else:
                    echo_nok()
        return status

    def start_watcher(self, cli_display=True, indent=0, **properties):
        name = properties["name"]
        if cli_display:
            echo_running(" " * indent + "- Starting of %s" % name)
            statuses = self.statuses()
            if name not in statuses:
                echo_nok("(not found)")
                return None
            if statuses[name] == "starting":
                echo_warning("(already starting)")
                return "starting"
            if statuses[name] == "active":
                echo_warning("(already started)")
                return "active"
        tmp = self.cmd("start", **properties)
        status = tmp.get("status", None) if tmp is not None else None
        if cli_display:
            if status == "ok":
                echo_ok()
            else:
                echo_nok("(can't start)")
        return status

    def stop_watcher_and_wait(self, cli_display=True, timeout=300, slow=5,
                              indent=0, scheduled=False, **properties):
        first_iteration = True
        res = 0
        name = properties["name"]
        if cli_display:
            if scheduled:
                echo_running(" " * indent + "- Waiting for stop "
                             "of %s..." % name)
            else:
                echo_running(" " * indent + "- Stopping %s..." % name)
        before = datetime.datetime.now()
        after = datetime.datetime.now()
        slow_display = False
        while (after - before).total_seconds() < timeout:
            statuses = self.statuses()
            if name not in statuses:
                res = 1 if first_iteration else 2
                break
            if statuses[name] == "stopped":
                res = 1 if first_iteration and not scheduled else 2
                break
            first_iteration = False
            if statuses[name] != "stopping":
                self.stop_watcher(cli_display=False, check=False, **properties)
            time.sleep(1)
            after = datetime.datetime.now()
            delta = (after - before).total_seconds()
            if self.is_interactive and cli_display and delta > slow:
                print()
                print("    => waiting %i/%i" % (int(delta), timeout), end="")
                print('\033[1A', end="")
                slow_display = True
        if slow_display:
            print("\033[60C", end="")
            print("\033[K", end="")
        if cli_display:
            if res == 2:
                echo_ok()
            elif res == 1:
                echo_warning("(already stopped)")
            else:
                echo_nok()
        if slow_display:
            print("\033[K", end="")
        if res != 0:
            return True
        else:
            return False

    def statuses(self):
        tmp = self.cmd("status")
        if tmp is None:
            return None
        return tmp["statuses"]

    def list_pids(self, **properties):
        tmp = self.cmd("list", **properties)
        if tmp is None:
            return None
        return tmp["pids"]

    def options(self, **properties):
        tmp = self.cmd("options", **properties)
        if tmp is None:
            return None
        return tmp["options"]
