#! /usr/bin/env python
"""TODO:
    Make a real docstring with examples
    Add a remove option
    Test to see which versions of python this works on
"""

import argparse
import os
import re

def get_parser():
    """Create parser object for stdin"""
    parser = argparse.ArgumentParser(
        description=
        'Simple CLI tool for installing "terminalrc" for bash and fish'
    )
    parser.add_argument(
        '-f',
        '--bashrc',
        help='Specify the file path to your .bashrc',
        type=argparse.FileType('r+'),
        default=os.path.expanduser('~') + os.sep + '.bashrc'
    )
    return parser


def main(command=None):
    """Add or remove the bash script """
    # Get args from main or from console
    args = get_parser().parse_args(command.split() if command else None)

    # Format script for bashrc
    script = '\nsource ~/.terminalrc/bash.config'
    regex = re.compile(r'\nsource ~/\.terminalrc/bash\.config')
    with args.bashrc as bashrc:
        content = bashrc.read()
        if regex.search(content):
            print('Already installed :)')
        else:
            bashrc.write(script)
            print('Install successful!')


if __name__ == '__main__':
    main()
