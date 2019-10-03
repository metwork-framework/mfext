import argparse
import sys
from mfutil.net import get_simple_hostname

DESCRIPTION = "returns the 'simple' hostname (without network domain)"


def main():
    parser = argparse.ArgumentParser(description=DESCRIPTION)
    parser.parse_args()
    res = get_simple_hostname()
    if res is not None:
        print(res)
    else:
        sys.exit(1)


if __name__ == '__main__':
    main()
