import argparse
import sys
from mfutil.net import get_ip_for_hostname, get_real_ip

DESCRIPTION = "returns the IP address of the given HOSTNAME (current real IP "\
    " if no hostname is given)"


def main():
    parser = argparse.ArgumentParser(description=DESCRIPTION)
    parser.add_argument("hostname", nargs='?',
                        help="hostname to resolve as ip (can be empty)")
    args = parser.parse_args()
    if args.hostname is None:
        res = get_real_ip()
    else:
        res = get_ip_for_hostname(args.hostname)
    if res is not None:
        print(res)
    else:
        sys.exit(1)


if __name__ == '__main__':
    main()
