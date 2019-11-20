#!/usr/bin/env python
# -*- coding: utf-8 -*-

# FIXME !!!

#
# ============================
# ===== Projet SYNOPSIS ======
# ============================
#
# (c) 2009-2016, Météo-France
#

##
#
# @author Florian POURTUGAU <florian.pourtugau@meteo.fr>
# @since février 2016
# @file __ini_to_env.py
#

from __future__ import print_function
import codecs
import re
import argparse
import sys
import time
from os import environ
from configparser_extended import ExtendedConfigParser
from collections import OrderedDict
try:
    from mfutil import get_ipv4_for_hostname
except ImportError:
    print("mfutil not found", file=sys.stderr)
    sys.exit(1)


def read_config_file(parser, config, home):
    res = OrderedDict()
    for s in parser._sections:
        # On inclut les sections des fichiers de config à inclure
        if(s.startswith("INCLUDE_")):
            parser_included = ExtendedConfigParser(config=config,
                                                   inheritance='im')
            included_file = s[8:]
            data = codecs.open(home + "/config/" + included_file, "r", "utf-8")
            parser_included.read_file(data)
            res.update(read_config_file(parser_included, config, home))
        # On ajoute la section si elle n'y est pas ou on la met à jour
        # si elle a été incluse auparavant
        else:
            try:
                res[s].update(read_section(parser, s, home))
            except KeyError:
                res[s] = read_section(parser, s, home)
    return res


def read_section(parser, section, home):
    res = OrderedDict()
    for o in parser[section]:
        read_option(parser, section, home, o, res)
    return res


def read_option(parser, section, home, o, res):
    if("[" in o):
        opt = o[:o.find("[")]
    else:
        opt = o
    val = parser[section][opt]

    # Récupère le contenu d'une variable d'environnement
    if(re.match("^.*@@@[A-Z0-9_][A-Z0-9_]*@@@.*$", str(val))):
        name = val[(val.find("@@@") + 3):val.rfind("@@@")]
        res[opt] = val.replace("@@@" + name + "@@@", environ.get(name, ""))

    # Récupère le contenu d'une variable d'environnement
    if(re.match("^.*{{[A-Z0-9_][A-Z0-9_]*}}.*$", str(val))):
        name = val[(val.find("{{") + 2):val.rfind("}}")]
        res[opt] = val.replace("{{" + name + "}}", environ.get(name, ""))

    # Récupère le contenu d'un fichier en string en remplaçant les "\n"
    # par des ";"
    if(re.match("^~~~[\\.a-zA-Z0-9_][\\.a-zA-Z0-9_]*~~~$", str(val))):
        file_name = home + "/config/" + \
            val[(val.find("~~~") + 3):val.rfind("~~~")]
        data = codecs.open(file_name, "r", "utf-8")
        content = data.read()
        res[opt] = content.replace("\n", ";")

    # Si l'option finit par "_HOSTNAME" ou s'appelle "hostname", on créé
    # la variable "HOSTNAME_IP" correspondante
    if(opt.lower().endswith("_hostnames") or opt.lower() == "hostnames"):
        if(opt + "_IP" not in res):
            ip_list = []
            if(re.match("@@@[A-Z0-9_][A-Z0-9_]*@@@", str(val))):
                hostname_list = res[opt].split(parser.list_separator)
            else:
                hostname_list = val.split(parser.list_separator)
            for hostname in hostname_list:
                if(get_ip_var(opt, hostname) is not None):
                    ip_list.append(str(get_ip_var(opt, hostname)))
                else:
                    ip_list.append("dns_error")
            res[opt + "_IP"] = ";".join(ip_list)

    if(opt.lower().endswith("_hostname") or opt.lower() == "hostname"):
        if(opt + "_IP" not in res):
            if(re.match("@@@[A-Z0-9_][A-Z0-9_]*@@@", str(val))):
                if(get_ip_var(opt, res[opt]) is not None):
                    res[opt + "_IP"] = get_ip_var(opt, res[opt])
                else:
                    res[opt + "_IP"] = "dns_error"
            else:
                if(get_ip_var(opt, val) is not None):
                    res[opt + "_IP"] = get_ip_var(opt, val)
                else:
                    res[opt + "_IP"] = "dns_error"

    if(opt not in res):
        res[opt] = val


def get_ip_var(opt, val):
    # Si c'est "null" ou si c'est une socket Unix
    if(val.lower() == "null" or val.startswith("/")):
        return val
    else:
        return get_ipv4_for_hostname(str(val))


def main():
    arg_parser = argparse.ArgumentParser()
    arg_parser.add_argument(
        "path",
        help="Chemin du fichier de config à visualiser")
    arg_parser.add_argument(
        "module",
        help="Précise le module dans lequel se trouve le fichier de config")
    args = arg_parser.parse_args()

    parser = ExtendedConfigParser(
        config=environ.get("MFCONFIG", "GENERIC"),
        strict=False, inheritance='im')
    data = codecs.open(args.path, "r", "utf-8")
    module = args.module

    home_env = str(module) + "_HOME"
    home = environ.get(home_env)
    parser.read_file(data)
    res_dict = read_config_file(parser, parser.config_name, home)
    for s in res_dict:
        for o in res_dict[s]:
            print("export " + module.upper() + "_" + s.upper() + "_" +
                  o.upper() + "=\"" + str(res_dict[s][o]) + "\"")

    print("export %s_CONF_GENERATION_TIME=%i" % (module.upper(), time.time()))


main()
