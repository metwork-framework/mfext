import argparse
import sys
from mfutil.net import ping_tcp_port

DESCRIPTION = "test if a tcp host/port is reachable, open and listened"


def main():
    parser = argparse.ArgumentParser(description=DESCRIPTION)
    parser.add_argument("host", help="hostname/ip to test")
    parser.add_argument("port", help="tcp port to test", type=int)
    parser.add_argument("--timeout", help="timeout (in seconds)", type=int,
                        default=5)
    parser.add_argument("--silent", help="if set, nothing is sent on stdout",
                        action="store_true")
    args = parser.parse_args()
    res = ping_tcp_port(args.host, args.port, timeout=args.timeout)
    if res:
        if not args.silent:
            print("tcp port %s:%i is ok" % (args.host, args.port))
        sys.exit(0)
    if not args.silent:
        print("tcp port %s:%i is not ok" % (args.host, args.port))
    sys.exit(1)


if __name__ == '__main__':
    main()
