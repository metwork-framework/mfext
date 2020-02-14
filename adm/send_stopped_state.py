#!/usr/bin/env python

import os
import sys
import requests

MFMODULE_RUNTIME_HOME = os.environ["MFMODULE_RUNTIME_HOME"]
MFMODULE_VERSION = os.environ["MFMODULE_VERSION"]
MFMODULE = os.environ['MFMODULE']
MFCOM_HOSTNAME = os.environ['MFCOM_HOSTNAME']


def get_status():
    status = "unknown"
    status_code = 0
    try:
        with open("%s/var/status" % MFMODULE_RUNTIME_HOME, "r") as f:
            status = f.read().strip().lower()
        if status in ('running',):
            status_code = 2
        elif status in ('error', 'unknown'):
            status_code = 0
        else:
            status_code = 1
    except Exception:
        pass
    return {"status": status, "status_code": status_code}


if MFMODULE == "MFADMIN":
    admin_hostname_ip = "127.0.0.1"
    admin_http_port = os.environ.get("MFADMIN_INFLUXDB_HTTP_PORT", None)
else:
    admin_hostname_ip = os.environ.get('%s_ADMIN_HOSTNAME_IP' % MFMODULE, None)
    admin_http_port = os.environ.get('%s_ADMIN_INFLUXDB_HTTP_PORT' % MFMODULE,
                                     None)
if admin_hostname_ip is None or admin_hostname_ip == "null":
    sys.exit(0)
if admin_http_port is None:
    sys.exit(0)
url = "http://%s:%s/write?db=metrics" % (admin_hostname_ip, admin_http_port)
data = 'metwork_version,bypassbasicstats=1,host=%s,modname=%s,' \
    'module=%s,resolution=fullres status="stopped",version="%s",' \
    'status_code=1i' % \
    (MFCOM_HOSTNAME, MFMODULE.lower(), MFMODULE.lower(), MFMODULE_VERSION)
print(requests.post(url, timeout=10, data=data).text)
