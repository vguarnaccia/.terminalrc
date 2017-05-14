#! /usr/bin/env python
# -*- coding: utf-8 -*-
"""A simple script for installing the terminal configuration files into your bashrc or config.fish.

This script is meant to be used as a command line interface tool. It can also remove the script if
you no longer want it. You can find terminalrc at https://github.com/vguarnaccia/terminalrc

Examples:
    $ python installer.py
    Install Successful!

    $ python installer.py
    Already installed :)

    $ python installer.py --remove bashrc
    Script removed. Remember to delete ~/.terminalrc

TODO:
    * Implement for config.fish.
"""

import argparse
from collections import namedtuple
import os
import re

def parse_args(params=None):
    """Create Namespace object from a string or argv[1:].

    Arg:
        params (str): a string in the form of command arguments.
            If none provided, it will pull from argv.
    """
    parser = argparse.ArgumentParser(description=
                                     'Simple CLI tool to install "terminalrc" for bash and fish')
    parser.add_argument(
        '-b',
        '--bashrc',
        help='Specify the file path to your .bashrc if it\'s not ~/.bashrc',
        type=argparse.FileType('r+'),
        default=os.path.expanduser('~') + os.sep + '.bashrc'
    )
    parser.add_argument('--remove', choices=['bashrc', 'config.fish'],
                        help='remove script from bashrc or config.fish')
    default_fish = os.path.join(os.path.expanduser('~'),
                                '.config', 'fish', 'config.fish')
    parser.add_argument(
        '-f',
        '--fish',
        help=('Specify the file path to your config.fish. '
              'It\'s probably %s' % default_fish),
        type=argparse.FileType('r+'),
    )
    return parser.parse_args(params.split() if params else None)


# A Script needs text and a regex that matches the text
Script = namedtuple('Script', ['text', 'regex'])


def main(params=None):
    """Add or remove the bash script

    TODO:
        Extend for config.fish
    """
    # Get args from main or from console
    args = parse_args(params)

    # Script for bashrc
    bash_script = Script('\nsource ~/.terminalrc/bash.config',
                         re.compile(r'\nsource ~/\.terminalrc/bash\.config'))
    with args.bashrc as bashrc:
        content = bashrc.read()
        if args.remove == 'bashrc':

            # Rewrite bashrc without script
            uninstalled = bash_script.regex.sub('', content)
            bashrc.seek(0)
            bashrc.write(uninstalled)
            bashrc.truncate()
            print('Script removed. Remember to delete ~/.terminalrc')
        elif bash_script.regex.search(content):
            print('Already installed :)')
        else:
            bashrc.write(bash_script.text)
            print('Install successful!')


if __name__ == '__main__':
    main()
