## terminalrc

This is how I setup my terminal. It currently supports bash and should work on [Cygwin](https://www.cygwin.com/). I plan to add [fish](http://fishshell.com/) as I use it more.

## Getting Started

### Prerequisites

All you need is bash, git, and python 2 or 3 (for the installation script). I assume you have a decent .bashrc that colorizes your command line which you wish to extend without modifying too much. In case you don't, I included a template for a debian system.

### Installation

Install with:

    git clone https://github.com/vguarnaccia/terminalrc.git ~/.terminalrc/
    python ~/.terminalrc/installer.py
    source ~/.bashrc

Uninstall bash config with:

    python ~/.terminalrc/installer.py --remove bashrc

And then delete `.terminalrc/`

### Extendible

If you need any local configurations, you can add them to `~/.terminalrc/bash.local`.

### Platforms

I've tested it on Linux and [Cygwin](https://www.cygwin.com/). It *should* also work on Mac, where it installs the script on .bash_profile instead of .bashrc.

### Bash Features

* Each time you open a new terminal, a quick description of a random command will print. There's room for improvement on that feature but it's a good way to learn about more obscure commands.
* Smart Autocomplete: case-insensitive autocomplete for directories and git autocomplete.
* Colorized prompt, manpages and commands.
* `extract` command which will try to decompress various archive types.

#### Extended Navigation Commands

* `l`: Horizontally list content (`ls -CF`).
* `ll`: Vertically list content (`ls -AhlF`).
* `cdl`: Change directory and list contents.
* `mkcd`: Make directory and enter it.

You should also use the command `tree`; it's great for viewing directory hierarchies.

#### Git Aliases

Because git commands are too long to type fully. If you are doing any complicated git operations, it is worth using a GUI. I prefer [GitKracken](https://www.gitkraken.com/) at the moment. It's currently freemium.

* `gs`: `git status`
* `ga`: `git add`
* `gd`: `git diff`
* `gdc`: `git diff --cached`
* `grm`: `git rm`
* `grc`: `git rm --cached`
* `gc`: quick commit message, i.e. `gc add new alias` = `git commmit -m "add new alias"`
* `gl`: `git log` but much prettier.
* `gpl`: `git pull`
* `gpu`: `git push`
* `gbr`: `git branch -vv` -- verbose branching
* `gst`: `git stash`
* `gcache`: extend credentials timeout to 1 hour (for `gpu`/`gpl`).
