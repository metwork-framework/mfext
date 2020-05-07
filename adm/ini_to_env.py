import codecs
import re
import os
import sys
import time
import shlex

from mfutil import get_ipv4_for_hostname
from opinionated_configparser import OpinionatedConfigParser


def _legacy_env(val):
    # Legacy env vars
    # (the recommended way is to use envtpl/jinja2 placeholders)
    if re.match("^.*@@@[A-Z0-9_][A-Z0-9_]*@@@.*$", val):
        name = val[(val.find("@@@") + 3):val.rfind("@@@")]
        val = val.replace("@@@" + name + "@@@", os.environ.get(name, ""))
    return val


def _legacy_file(val, directory):
    if directory is None:
        print(
            "ERROR: specify a directory with "
            "--legacy-file-inclusion-directory "
            "when using --legacy-file-inclusion option",
            file=sys.stderr,
        )
        sys.exit(1)
    # Retrieve content of a file, replacing "\n" by ";"
    if re.match("^~~~[\\.a-zA-Z0-9_][\\.a-zA-Z0-9_]*~~~$", val):
        file_name = os.path.join(
            directory, val[(val.find("~~~") + 3):val.rfind("~~~")]
        )
        data = codecs.open(file_name, "r", "utf-8")
        content = data.read()
        val = content.replace("\n", ";")
    return val


def _resolve(val):
    if val.lower() == "null" or val.startswith("/"):
        # If it's "null" or linux socket
        return val
    return get_ipv4_for_hostname(str(val))


def print_env_var(prefix, section, option, val):
    print(
        "export %s_%s_%s=%s"
        % (prefix.upper(), section.upper(), option.upper(), shlex.quote(val))
    )


def add_env_var(env_var_dict, prefix, section, option, val):
    name = "%s_%s_%s" % (prefix.upper(), section.upper().replace('-', '_'),
                         option.upper().replace('-', '_'))
    env_var_dict[name] = val


def add_resolved_ip_var(env_var_dict, prefix, section, option, val):
    new_val = _resolve(val)
    if new_val is None:
        new_val = "dns_error"
    add_env_var(env_var_dict, prefix, section, option + "_IP", new_val)


def add_resolved_ips_var(env_var_dict, prefix, section, option, val):
    hostname_list = val.split(";")
    new_vals = []
    for hostname in hostname_list:
        new_val = _resolve(hostname)
        if new_val is None:
            new_val = "dns_error"
        new_vals.append(new_val)
    add_env_var(
        env_var_dict, prefix, section, option + "_IP", ";".join(new_vals)
    )


def make_env_var_dict(
    configuration_name,
    prefix,
    paths,
    legacy_env=False,
    legacy_file_inclusion=False,
    resolve=False,
    legacy_file_inclusion_directory=None,
    generation_time=False,
    ignore_keys_starting_with="_",
):
    if prefix is None:
        prefix = os.environ.get("MFMODULE", None)
        if prefix is None:
            print(
                "ERROR: can't determine PREFIX, use --prefix option",
                file=sys.stderr,
            )
            sys.exit(1)
    if configuration_name is None:
        configuration_name = os.environ.get("MFCONFIG", None)
        if configuration_name is None:
            configuration_name = "GENERIC"
    configuration_name = configuration_name.lower()
    parser = OpinionatedConfigParser(configuration_name=configuration_name)
    paths = [x for x in paths if os.path.isfile(x)]
    parser.read(paths)
    env_var_dict = {}
    for section in parser.sections():
        for option in parser.options(section):
            if ignore_keys_starting_with and \
                    option.strip().startswith(ignore_keys_starting_with):
                continue
            val = parser.get(section, option)
            if legacy_env:
                val = _legacy_env(val)
            if legacy_file_inclusion:
                lfid = legacy_file_inclusion_directory
                val = _legacy_file(val, lfid)
            if resolve:
                if not parser.has_option(section, "%s_ip" % option):
                    if (
                        option.lower().endswith("_hostname")
                        or option.lower() == "hostname"
                    ):
                        add_resolved_ip_var(
                            env_var_dict, prefix, section, option, val
                        )
                    elif (
                        option.lower().endswith("_hostnames")
                        or option.lower() == "hostnames"
                    ):
                        add_resolved_ips_var(
                            env_var_dict, prefix, section, option, val
                        )
            add_env_var(env_var_dict, prefix, section, option, val)
    if generation_time:
        add_env_var(
            env_var_dict, prefix, "conf", "generation_time",
            str(int(time.time()))
        )
    return env_var_dict
