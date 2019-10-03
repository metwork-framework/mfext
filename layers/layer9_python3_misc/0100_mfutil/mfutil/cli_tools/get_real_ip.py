import argparse
import sys
from mfutil.net import get_real_ip

DESCRIPTION = "returns the 'real' ip (not 127.0.0.1)"


def main():
    parser = argparse.ArgumentParser(description=DESCRIPTION)
    parser.parse_args()
    res = get_real_ip()
    if res is not None:
        print(res)
    else:
        sys.exit(1)


if __name__ == '__main__':
    main()
