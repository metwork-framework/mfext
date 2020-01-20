#!/usr/bin/env python3

import codecs
import re
import os
import argparse
import sys
import time
import shlex

from mfutil import get_ipv4_for_hostname
from opinionated_configparser import OpinionatedConfigParser


def legacy_env(val):
    # Legacy env vars
    # (the recommended way is to use envtpl/jinja2 placeholders)
    if re.match("^.*@@@[A-Z0-9_][A-Z0-9_]*@@@.*$", val):
        name = val[(val.find("@@@") + 3):val.rfind("@@@")]
        val = val.replace("@@@" + name + "@@@", os.environ.get(name, ""))
    return val


def legacy_file(val, directory):
    # Retrieve content of a file, replacing "\n" by ";"
    if re.match("^~~~[\\.a-zA-Z0-9_][\\.a-zA-Z0-9_]*~~~$", val):
        file_name = os.path.join(
            directory, val[(val.find("~~~") + 3):val.rfind("~~~")]
        )
        data = codecs.open(file_name, "r", "utf-8")
        content = data.read()
        val = content.replace("\n", ";")
    return val


def resolve(val):
    if val.lower() == "null" or val.startswith("/"):
        # If it's "null" or linux socket
        return val
    return get_ipv4_for_hostname(str(val))


def print_env_var(prefix, section, option, val):
    print(
        'export %s_%s_%s=%s'
        % (prefix.upper(), section.upper(), option.upper(), shlex.quote(val))
    )


def print_resolved_ip_var(prefix, section, option, val):
    new_val = resolve(val)
    if new_val is None:
        new_val = "dns_error"
    print_env_var(prefix, section, option + "_IP", new_val)


def print_resolved_ips_var(prefix, section, option, val):
    hostname_list = val.split(";")
    new_vals = []
    for hostname in hostname_list:
        new_val = resolve(val)
        if new_val is None:
            new_val = "dns_error"
        new_vals.append(new_val)
    print_env_var(prefix, section, option + "_IP", ";".join(new_vals))


if __name__ == "__main__":
    arg_parser = argparse.ArgumentParser(
        "convert one or several ini " "configuration files to env vars"
    )
    arg_parser.add_argument(
        "--prefix",
        help="the prefix to use for generated env var, if not set, we will "
        "use the content of MFMODULE env var",
    )
    arg_parser.add_argument(
        "--configuration-name",
        help="the configuration name to select configuration variants "
        "(if not set, we will use the content of MFCONFIG env var, if not "
        "set, 'GENERIC' will be used)",
        default=None,
    )
    arg_parser.add_argument(
        "--resolve",
        action="store_true",
        help="if set, keys ending by hostname or hostnames will be resolved "
        "and new env vars _IP or _IPS will be added",
    )
    arg_parser.add_argument(
        "--legacy-env",
        action="store_true",
        help="if set, legacy support of @@@ENV_VAR@@@",
    )
    arg_parser.add_argument(
        "--generation-time",
        action="store_true",
        help="if set, add a env var with generation time",
    )
    arg_parser.add_argument(
        "--legacy-file-inclusion",
        action="store_true",
        help="if set, legacy support of ~~~filename~~~",
    )
    arg_parser.add_argument(
        "--legacy-file-inclusion-directory",
        help="the directory to use for --legacy-file-inclusion",
    )
    arg_parser.add_argument(
        "path",
        nargs="+",
        help="full path of the ini file (if there are "
        "several files, the last one has the biggest priority)",
    )
    args = arg_parser.parse_args()
    if args.prefix is None:
        prefix = os.environ.get("MFMODULE", None)
        if prefix is None:
            print(
                "ERROR: can't determine PREFIX, use --prefix option",
                file=sys.stderr,
            )
            sys.exit(1)
    else:
        prefix = args.prefix
    if args.configuration_name is None:
        configuration_name = os.environ.get("MFCONFIG", None)
        if configuration_name is None:
            configuration_name = "GENERIC"
    else:
        configuration_name = args.configuration_name
    configuration_name = configuration_name.lower()
    parser = OpinionatedConfigParser(configuration_name=configuration_name)
    paths = [x for x in args.path if os.path.isfile(x)]
    parser.read(paths)
    for section in parser.sections():
        for option in parser.options(section):
            val = parser.get(section, option)
            if args.legacy_env:
                val = legacy_env(val)
            if args.legacy_file_inclusion:
                lfid = args.legacy_file_inclusion_directory
                val = legacy_file(val, lfid)
            if args.resolve:
                if not parser.has_option(section, "%s_ip" % option):
                    if (
                        option.lower().endswith("_hostname")
                        or option.lower() == "hostname"
                    ):
                        print_resolved_ip_var(prefix, section, option, val)
                    elif (
                        option.lower().endswith("_hostnames")
                        or option.lower() == "hostnames"
                    ):
                        print_resolved_ips_var(prefix, section, option, val)
            print_env_var(prefix, section, option, val)
    if args.generation_time:
        print(
            "export %s_CONF_GENERATION_TIME=%i" % (prefix.upper(), time.time())
        )
