#!/usr/bin/env python3
# extract module status to json file

import os
import re
import sys
import json
from datetime import datetime, timezone

MFMODULE_RUNTIME_HOME = os.environ["MFMODULE_RUNTIME_HOME"]

# read stdin and split lines
data = sys.stdin.read()
lines = data.split("\n")

# init json result
result = {"status": {}}

# append date
ISO_8601_FORMAT = "%Y-%m-%dT%H:%M:%SZ"
result["date"] = datetime.now(timezone.utc).strftime(ISO_8601_FORMAT)

# regular expression for extractng message and status
# ex: - Checking circus status...  [ OK ]
pattern = r"-\s(Check|Collect|Test)ing\s(?P<message>[A-Za-z\s_:()]+)" \
               r"(\.\.\.)?\s*\[\s(?P<status>[A-Z]+)\s\]"

# scan status lines
for line in lines:
    match = re.search(pattern, line)
    if match:
        message = match.group("message")
        status = match.group("status")
        result["status"][message] = status

# build json output
json_output = json.dumps(result, indent=4)

# write to file
with open("%s/var/status.json" % MFMODULE_RUNTIME_HOME, "w") as f:
    f.write(json_output)

