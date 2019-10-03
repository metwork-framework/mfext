import argparse
from mfutil.net import get_domainname

DESCRIPTION = "returns the network domain"


def main():
    parser = argparse.ArgumentParser(description=DESCRIPTION)
    parser.parse_args()
    res = get_domainname()
    if res is not None:
        print(res)


if __name__ == '__main__':
    main()
