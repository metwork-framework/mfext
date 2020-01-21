from mflog import getLogger
from mfutil import BashWrapper

LOGGER = getLogger("circus_hooks")


def _call(cmd):
    LOGGER.info("Calling %s..." % cmd)
    r = BashWrapper(cmd)
    if r.code != 0:
        msg = "Bad return code: %i from cmd: %s with output: %s" % \
              (r.code, cmd, str(r).replace("\n", " "))
        LOGGER.warning(msg)
        return False
    return True


def _conditional_call(prefix, watcher_name, params=None):
    if watcher_name is not None:
        cmd = "%s_%s" % (prefix, watcher_name)
    else:
        cmd = prefix
    r = BashWrapper("which %s" % cmd)
    if r.code == 0:
        if params is not None:
            cmd = "%s %s" % (cmd, " ".join(params))
        return _call(cmd)
    else:
        return True


def before_start_shell(watcher, arbiter, hook_name, **kwargs):
    return _conditional_call("before_start", watcher.name)


def after_stop_shell(watcher, arbiter, hook_name, **kwargs):
    return _conditional_call("after_stop", watcher.name)


def after_start_shell(watcher, arbiter, hook_name, **kwargs):
    return _conditional_call("after_start", watcher.name)


def before_stop_shell(watcher, arbiter, hook_name, **kwargs):
    return _conditional_call("before_stop", watcher.name)


def before_signal_shell(watcher, arbiter, hook_name, pid, signum, **kwargs):
    return _conditional_call("before_signal", watcher.name, [pid, signum])


def after_signal_shell(watcher, arbiter, hook_name, pid, signum, **kwargs):
    return _conditional_call("before_signal", watcher.name, [pid, signum])


def before_signal_shell2(watcher, arbiter, hook_name, pid, signum, **kwargs):
    return _conditional_call("before_signal", None,
                             [watcher.name, str(pid), str(signum)])


def after_signal_shell2(watcher, arbiter, hook_name, pid, signum, **kwargs):
    return _conditional_call("before_signal", None,
                             [watcher.name, str(pid), str(signum)])
