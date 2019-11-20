#!/usr/bin/env python3

from __future__ import print_function
import bash
import sys
import psutil
try:
    from mfutil.net import get_simple_hostname, get_full_hostname, \
        get_domainname, get_real_ip
except ImportError:
    print("mfutil not found", file=sys.stderr)
    sys.exit(1)


def profile_error(message):
    print("ERROR: %s" % message, file=sys.stderr)
    print("export PROFILE_ERROR=1")
    sys.exit(1)


# cpu
cmd = "lscpu --parse=SOCKET |grep -v '^#' |sort |uniq |wc -l"
physical_processors_result = bash.bash(cmd)
if physical_processors_result.code != 0:
    profile_error("can't execute %s" % cmd)
physical_processors = int(physical_processors_result.stdout)
cmd = "lscpu --parse=CORE |grep -v '^#' |sort |uniq |wc -l"
physical_cores_result = bash.bash(cmd)
if physical_cores_result.code != 0:
    profile_error("can't execute %s" % cmd)
physical_cores = int(physical_cores_result.stdout)
print("export MFCOM_HARDWARE_NUMBER_OF_PHYSICAL_PROCESSORS=%i" %
      physical_processors)
print("export MFCOM_HARDWARE_NUMBER_OF_CPU_CORES=%i" %
      physical_cores)
print("export MFCOM_HARDWARE_NUMBER_OF_CPU_CORES_PLUS_1=%i" %
      max(physical_cores / 2, 1))
print("export MFCOM_HARDWARE_NUMBER_OF_CPU_CORES_PLUS_1=%i" %
      (physical_cores + 1))
print("export MFCOM_HARDWARE_NUMBER_OF_CPU_CORES_MULTIPLIED_BY_2=%i" %
      (physical_cores * 2))
for divide_by in (2, 3, 4, 6, 8):
    print("export MFCOM_HARDWARE_NUMBER_OF_CPU_CORES_DIVIDED_BY_%i=%i" %
          (divide_by, max(physical_cores / divide_by, 1)))

# memory
memory_kb = psutil.virtual_memory().total / 1024
print("export MFCOM_HARDWARE_PHYSICAL_MEMORY=%i" % memory_kb)
for divide_by in (2, 3, 4, 6, 8, 16):
    print("export MFCOM_HARDWARE_PHYSICAL_MEMORY_DIVIDED_BY_%i=%i" %
          (divide_by, memory_kb / divide_by))

# network
print("export MFCOM_HOSTNAME=%s" % get_simple_hostname())
print("export MFCOM_HOSTNAME_FULL=%s" % get_full_hostname())
print("export MFCOM_DOMAIN=%s" % get_domainname())
print("export MFCOM_HOSTNAME_IP=%s" % get_real_ip())
