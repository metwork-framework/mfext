#!/usr/bin/env python3

from mfext.ini_to_env import make_env_var_dict
import argparse
import shlex


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
        default=None,
        help="the directory to use for --legacy-file-inclusion",
    )
    arg_parser.add_argument(
        "path",
        nargs="+",
        help="full path of the ini file (if there are "
        "several files, the last one has the biggest priority)",
    )
    args = arg_parser.parse_args()
    env_var_dict = make_env_var_dict(
        args.configuration_name,
        args.prefix,
        args.path,
        legacy_env=args.legacy_env,
        legacy_file_inclusion=args.legacy_file_inclusion,
        legacy_file_inclusion_directory=args.legacy_file_inclusion_directory,
        generation_time=True,
        resolve=args.resolve
    )
    for k, v in env_var_dict.items():
        print("export %s=%s" % (k, shlex.quote(v)))
