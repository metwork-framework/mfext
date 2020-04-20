import os

MFMODULE = os.environ['MFMODULE']
MFHOSTNAME = os.environ['MFHOSTNAME']
MFMODULE_VERSION = os.environ.get('MFMODULE_VERSION', 'unknown')


def transform_func(dict_object):
    if "name" in dict_object:
        # FIXME: don't hardcode elasticsearch here
        # But it's difficult to block elasticsearch logger where it's used only
        # in jsonlog2elasticsearch/jsonsyslog2elasticsearch
        if dict_object['name'] in ("elasticsearch", "jsonlog2elasticsearch",
                                   "jsonsyslog2elasticsearch"):
            return None
    if "module" not in dict_object:
        dict_object["module"] = MFMODULE
    if "hostname" not in dict_object:
        dict_object["hostname"] = MFHOSTNAME
    if "module_version" not in dict_object:
        dict_object["module_version"] = MFMODULE_VERSION
    return dict_object
