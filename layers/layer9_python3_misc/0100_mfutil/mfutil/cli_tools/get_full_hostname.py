import argparse
import sys
from mfutil.net import get_full_hostname

DESCRIPTION = "returns the 'full' hostname (with network domain)"


def main():
    parser = argparse.ArgumentParser(description=DESCRIPTION)
    parser.parse_args()
    res = get_full_hostname()
    if res is not None:
        print(res)
    else:
        sys.exit(1)


if __name__ == '__main__':
    main()
