import os
import sys
import re
from signal import signal, SIGPIPE, SIG_DFL
signal(SIGPIPE, SIG_DFL)

import argparse
p = argparse.ArgumentParser()
p.add_argument('-a', '--absolute', action='store_true', help='return absolute path')
p.add_argument('-r', '--relative', action='store_true', help='return relative path')
p.add_argument('-t', '--tilde', action='store_true', help='$HOME to "~"')
p.add_argument('-d', '--dir', action='store_true', help='put suffix "/"')
args = p.parse_args()

line = sys.stdin.readline()
while line:
    line = line.strip("\n")
    if args.absolute:
        line = os.path.abspath(line)
    elif args.relative:
        line = os.path.relpath(line)
    else:
        line = os.path.normpath(line)
    if args.tilde and line.startswith(os.environ['HOME']):
        line = line.replace(os.environ['HOME'], '~')
    if args.dir and line != '/':
        line += '/'
    print(line)
    line = sys.stdin.readline()

