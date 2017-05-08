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
        '-i',
        '--indent',
        dest='indent',
        help=('Select the indentation style used in your bashrc.'
              'Common examples includes 2, 4, or 8 spaces as well as tabs'),
        type=str,
        default='    '
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
    script_tpl = ('\n'
                  'if [ -f ~/.bashrc ]; then\n'
                  '{indent}for f in ~/.terminalrc/bashrcs/*; do\n'
                  '{indent}{indent}source "$f"\n'
                  '{indent}done\n'
                  'fi')
    script = script_tpl.format(indent=args.indent)

    regex = re.compile(r'if \[ -f ~\/\.bashrc \]; then\s*'
                       r'for f in ~\/\.terminalrc\/bashrcs\/\*; do\s*'
                       r'source "\$f"\s*done\s*fi')
    with args.bashrc as bashrc:
        content = bashrc.read()
        if regex.search(content):
            print('Already installed :)')
        else:
            bashrc.write(script)
            print('Install successful!')


if __name__ == '__main__':
    main()
