#!/usr/bin/env python3

import os
import sys
from mflog import get_logger
from mfutil import BashWrapper, get_tmp_filepath
from mfutil.plugins import get_installed_plugins

MFMODULE_HOME = os.environ.get("MFMODULE_HOME", None)
MFMODULE = os.environ.get("MFMODULE", None)
LOGGER = get_logger("_make_crontab.py")


if not os.path.isfile(f"{MFMODULE_HOME}/config/crontab"):
    sys.exit(0)

# FIXME: fix to ensure compatibility with existing plugins using
# old variables names MODULE* (to be removed)
for var in ["MODULE", "MODULE_HOME", "MODULE_LOWERCASE", "MODULE_VERSION",
            "MODULE_STATUS", "MODULE_RUNTIME_HOME", "MODULE_RUNTIME_USER",
            "MODULE_RUNTIME_SUFFIX", "MODULE_PLUGINS_BASE_DIR"]:
    if var not in os.environ:
        continue
    os.environ[f"MF{var}"] = os.environ[var]

# FIXME: deprecated => remove for 0.11 release
os.environ["RUNTIME_SUFFIX"] = ""

x = BashWrapper(f"cat {MFMODULE_HOME}/config/crontab "
                "|envtpl --reduce-multi-blank-lines")
if not x:
    LOGGER.critical("can't build module level crontab, details: %s" % x)
    sys.exit(1)
print(x.stdout)

plugins = []
try:
    plugins = get_installed_plugins()
except Exception:
    pass
for plugin in plugins:
    if not os.path.isfile(f"{plugin['home']}/crontab"):
        continue
    x = BashWrapper(
        f"cat {plugin['home']}/crontab "
        "| grep -v '^#' |grep [^[:space:]] "
        f"|plugin_wrapper {plugin['name']} -- "
        "envtpl --reduce-multi-blank-lines"
    )
    if not x:
        tmpfile = get_tmp_filepath(prefix="crontabdebug")
        with open(tmpfile, "w") as f:
            f.write("***** plugin %s crontab error details *****\n\n" %
                    plugin['name'])
            f.write("%s\n" % x)
        LOGGER.warning(f"problem with {plugin['home']}/crontab "
                       "file: bad syntax? => ignoring it (details in %s)",
                       tmpfile)
        continue
    if len(x.stdout.strip()) > 0:
        print(f"##### BEGINNING OF METWORK {MFMODULE} "
              f"PLUGIN {plugin['name']} CRONTAB #####")
        print(x.stdout)
        print(f"##### END OF METWORK {MFMODULE} "
              f"PLUGIN {plugin['name']} CRONTAB #####")
