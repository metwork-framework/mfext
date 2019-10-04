from __future__ import print_function
import argparse
from mfutil import kill_process_and_children

DESCRIPTION = "recursively kill (SIGKILL) a whole process tree"


def main():
    parser = argparse.ArgumentParser(description=DESCRIPTION)
    parser.add_argument('pid', type=int,
                        help='root process pid (to kill)')
    args = parser.parse_args()
    kill_process_and_children(args.pid)


if __name__ == '__main__':
    main()
