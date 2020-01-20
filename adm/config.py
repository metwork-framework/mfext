#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse
import codecs
from opinionated_configparser import OpinionatedConfigParser


def print_file(parser):
    for s in parser.sections():
        print(s)


def print_section(parser, section):
    for o in parser.options(section):
        print(o)


def print_option(parser, section, option):
    print(parser[section][option])


def main():
    arg_parser = argparse.ArgumentParser(
        description="Lit le contenu d'un fichier .ini")
    arg_parser.add_argument(
        "path",
        help="Chemin du fichier de config a visualiser")
    arg_parser.add_argument(
        "section",
        help="Precise la section a afficher",
        nargs='?',
        default=None)
    arg_parser.add_argument(
        "option",
        help="Precise l'option a afficher",
        nargs='?',
        default=None)
    arg_parser.add_argument(
        "config",
        help="Precise la config a utiliser pour l'affichage",
        nargs='?',
        default=None)
    args = arg_parser.parse_args()

    if(args.config):
        parser = OpinionatedConfigParser(configuration_name=args.config)
    else:
        parser = OpinionatedConfigParser()
    data = codecs.open(str(args.path), "r", "utf-8")
    parser.read_file(data)

    if(args.section):
        # Affichage de la valeur d'une option
        if(args.option):
            print_option(parser, args.section, args.option)

        # Affichage du contenu d'une section
        else:
            print_section(parser, args.section)

    # Affichage de l'ensemble des sections du fichier
    else:
        print_file(parser)


if __name__ == "__main__":
    main()
