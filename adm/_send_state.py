#!/usr/bin/env python

import os
import sys
import requests
import distro
import argparse

MFMODULE_VERSION = os.environ["MFMODULE_VERSION"]
MFMODULE = os.environ['MFMODULE']
MFHOSTNAME = os.environ['MFHOSTNAME']
IS_LINUX = sys.platform.startswith("linux")
OS_NAME = distro.name(pretty=True) if IS_LINUX else "unknown"


argparser = argparse.ArgumentParser(
    description="send module status to mfadmin immedialty and directly"
)
argparser.add_argument("STATE", nargs=1, help="state to send")
args = argparser.parse_args()
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
    'module=%s,resolution=fullres status="%s",version="%s",' \
    'os_name="%s",status_code=1i' % \
    (MFHOSTNAME, MFMODULE.lower(), MFMODULE.lower(), args.STATE[0],
     MFMODULE_VERSION, OS_NAME)
print(requests.post(url, timeout=10, data=data).text)
