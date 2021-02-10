#!/usr/bin/env python3

import os
import rich
import fnmatch
import datetime
import time
import mflog
from circus.client import CircusClient
from circus.exc import CallError
from mfutil.cli import MFProgress

LOGGER = mflog.get_logger("circus.py")


class MetWorkCircusClient(object):
    def __init__(self, timeout=10):
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

    def wait(self, timeout=10, cli_display=True):
        with self._mfprogress(cli_display=cli_display) as progress:
            txt = "- Waiting for circus daemon..."
            before = datetime.datetime.now()
            after = datetime.datetime.now()
            t = progress.add_task(txt, total=timeout)
            while (after - before).total_seconds() < timeout:
                if self.check():
                    progress.complete_task(t)
                    return True
                time.sleep(1)
                after = datetime.datetime.now()
                delta = (after - before).total_seconds()
                progress.update(t, completed=int(delta))
            progress.complete_task_nok(t)
            return False

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

    def stop_watcher(self, cli_display=True, indent=0, timeout=10,
                     **properties):
        name = properties["name"]
        with self._mfprogress(cli_display=cli_display) as progress:
            txt = " " * indent + "- Scheduling stop of %s" % name
            t = progress.add_task(txt, total=timeout)
            statuses = self.statuses()
            if name not in statuses:
                progress.complete_task_warning(t)
                return None
            if statuses[name] == "stopped":
                progress.complete_task_warning(t, "already stopped")
                return "stopped"
            if statuses[name] == "stopping":
                progress.complete_task_warning(t, "already stopping")
                return "stopping"
            before = datetime.datetime.now()
            after = datetime.datetime.now()
            while (after - before).total_seconds() < timeout:
                self.cmd("stop", **properties)
                statuses = self.statuses()
                if name not in statuses or statuses[name] in ("stopping", "stopped"):
                    progress.complete_task(t)
                    return statuses[name]
                time.sleep(1)
                after = datetime.datetime.now()
                delta = (after - before).total_seconds()
                progress.update(t, completed=int(delta))
            progress.complete_task_nok(t)
            return "failed"

    def start_watcher(self, cli_display=True, indent=0, timeout=10, **properties):
        name = properties["name"]
        with self._mfprogress(cli_display=cli_display) as progress:
            txt = " " * indent + "- Starting of %s" % name
            t = progress.add_task(txt, total=timeout)
            statuses = self.statuses()
            if name not in statuses:
                progress.complete_task_nok(t)
                return None
            if statuses[name] == "starting":
                progress.complete_task_warning(t, "already starting")
                return "starting"
            if statuses[name] == "active":
                progress.complete_task_warning(t, "already started")
                return "active"
            before = datetime.datetime.now()
            after = datetime.datetime.now()
            while (after - before).total_seconds() < timeout:
                tmp = self.cmd("start", **properties)
                status = tmp.get("status", None) if tmp is not None else None
                if status == "ok":
                    progress.complete_task(t)
                    return status
                time.sleep(1)
                after = datetime.datetime.now()
                delta = (after - before).total_seconds()
                progress.update(t, completed=int(delta))
            progress.complete_task_nok(t)
            return "failed"

    def start_watchers(self, cli_display=True, indent=0, **properties):
        names = properties["names"]
        for name in names:
            self.start_watcher(cli_display=cli_display, indent=indent, name=name,
                               **properties)

    def wait_watcher_started(self, cli_display=True, timeout=20,
                             indent=0, **properties):
        name = properties["name"]
        with self._mfprogress(cli_display=cli_display) as progress:
            txt = " " * indent + "- Waiting for start of %s..." % name
            t = progress.add_task(txt, total=timeout)
            before = datetime.datetime.now()
            after = datetime.datetime.now()
            while (after - before).total_seconds() < timeout:
                statuses = self.statuses()
                if name in statuses:
                    if statuses[name] == "active":
                        progress.complete_task(t)
                        return True
                time.sleep(1)
                after = datetime.datetime.now()
                delta = (after - before).total_seconds()
                progress.update(t, completed=int(delta))
            progress.complete_task_nok(t)
            return False

    def _mfprogress(self, cli_display=True):
        console = None
        if not cli_display:
            console = rich.console.Console(file=open(os.devnull, "w"))
        return MFProgress(console=console)

    def wait_watcher_stopped(self, cli_display=True, timeout=None,
                             indent=0, **properties):
        name = properties["name"]
        if timeout is None:
            timeout = 300
            try:
                timeout = int(self.options(name=name)['graceful_timeout'])
            except Exception:
                pass
        with self._mfprogress(cli_display=cli_display) as progress:
            txt = " " * indent + "- Waiting for stop of %s..." % name
            t = progress.add_task(txt, total=timeout)
            before = datetime.datetime.now()
            after = datetime.datetime.now()
            while (after - before).total_seconds() < timeout:
                statuses = self.statuses()
                if name not in statuses or statuses[name] == "stopped":
                    progress.complete_task(t)
                    return True
                time.sleep(1)
                after = datetime.datetime.now()
                delta = (after - before).total_seconds()
                progress.update(t, completed=int(delta))
            progress.complete_task_nok(t)
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
