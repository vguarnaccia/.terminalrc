#! /usr/bin/env python
# -*- coding: utf-8 -*-
"""A simple script for installing the terminal configuration files into your bashrc or zsh.

This script is meant to be used as a command line interface tool. It can also remove the script if
you no longer want it. You can find terminalrc at https://github.com/vguarnaccia/terminalrc

Examples:
    $ python installer.py -i bash
    Install Successful!

    $ python installer.py
    Already installed :)

    $ python installer.py --remove bashrc
    Script removed. Remember to delete ~/.terminalrc

"""

import argparse
import re
import sys
from collections import namedtuple
from os import path


def parse_args(params=None):
    """Create Namespace object from a string or argv[1:].

    Arg:
        params (str): a string in the form of command arguments.
            If none provided, it will pull from argv.
    """
    parser = argparse.ArgumentParser(description='Simple CLI tool to install "terminalrc" \
                                                  on bash or zsh')

    # Mac will source .bash_profile but not .bashrc
    bash_config = '.bashrc' if sys.platform != 'darwin' else '.bash_profile'
    default_bashrc_path = path.join(path.expanduser('~'), bash_config)

    parser.add_argument(
        '-b',
        '--bashrc',
        help='Specify the file path to your .bashrc if it\'s not ~/.bashrc',
        type=argparse.FileType('a+'),
        default=default_bashrc_path
    )
    default_zshrc_path = path.join(path.expanduser('~'), '.zshrc')
    parser.add_argument(
        '-z',
        '--zshrc',
        help='Specify the file path to your .zshrc if it\'s not ~/.zshrc',
        type=argparse.FileType('a+'),
        default=default_zshrc_path
    )
    parser.add_argument('-i', '--install', choices=['bashrc', 'zshrc'],
                        help='install script into bashrc or zshrc')
    parser.add_argument('--remove', choices=['bashrc', 'zshrc'],
                        help='remove script from bashrc or zshrc')
    return parser.parse_args(params.split() if params else None)


# A Script needs text and a regex that matches the text
Script = namedtuple('Script', ['text', 'regex'])


def insert_script(file, script):
    """Insert remove script into file."""
    file.seek(0)
    content = file.read()
    if script.regex.search(content):
        return 'Already installed :)'
    file.write(script.text)
    file.close()
    return 'Install successful!'


def remove_script(file, script):
    """Remove script from file."""
    file.seek(0)
    content = file.read()
    # Rewrite bashrc without script
    without_script = script.regex.sub('', content)
    file.seek(0)
    file.truncate()
    file.write(without_script)
    file.close()
    return 'Script removed. Remember to delete ~/.terminalrc'


def main(params=None):
    """Add or remove the bash script."""
    # Get args from main or from console
    args = parse_args(params)

    # Script for bashrc
    body = 'source ~/.terminalrc/bashrc'
    pattern = r'source ~\/.terminalrc\/(bashrc|zshrc)'
    bash_script = Script(body, re.compile(pattern))

    # Script for zshrc
    body = 'source ~/.terminalrc/zshrc'
    zsh_script = Script(body, re.compile(pattern))

    if args.install == 'bashrc':
        result = insert_script(args.bashrc, bash_script)
        print(result)
    elif args.install == 'zshrc':
        result = insert_script(args.zshrc, zsh_script)
        print(result)
    elif args.remove == 'bashrc':
        result = remove_script(args.bashrc, bash_script)
        print(result)
    elif args.remove == 'zshrc':
        result = remove_script(args.zshrc, zsh_script)
        print(result)
    else:
        print("I didn't understand that.")



if __name__ == '__main__':
    main()
