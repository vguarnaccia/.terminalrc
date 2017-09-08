## terminalrc

This is how I setup my terminal. It currently supports bash and zsh on Linux and [Cygwin](https://www.cygwin.com/ "Cygwin").

### Prerequisites

All you need is bash, git, and python 2 or 3 (for the installation script). I assume you have a decent .bashrc that colorizes your command line which you wish to extend without modifying too much. In case you don't, I included a template for a debian system.

### Installation

Install on bash with:

    git clone https://github.com/vguarnaccia/.terminalrc.git ~
    python ~/.terminalrc/installer.py
    source ~/.bashrc

Uninstall bash config with:

    python ~/.terminalrc/installer.py --remove bashrc

And then delete `.terminalrc/`

For zsh, follow the instructions above but replace bashrc with zshrc.

### Extendible

If you need any local configurations, you can add them to `~/.terminalrc/local`. This way they are read when using bash or zsh.

### Platforms

I've tested it on [Ubuntu](http://releases.ubuntu.com/16.04/ "Ubuntu") and [Cygwin](https://www.cygwin.com/ "Cygwin"). It *should* also work on Mac, where it installs the script on `.bash_profile` instead of `.bashrc`.

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

### Unwarranted Suggestions

Instead of using `ls` and `cd` everywhere when trying to understand a directory, use the `tree` command. When moving to a new directory, use [autojump](https://github.com/wting/autojump "autojump") instead of `cd`. [Silver Searcher](https://github.com/ggreer/the_silver_searcher "Silver Searcher") can be used in place of most `find`, `xargs`, `grep` combos. Lastly, `locate` is superior to `find` if the file you are looking for is a least a day old.

#### Git Aliases

Because git commands are too long to type fully. If you are doing any complicated git operations, it is worth using a GUI. I prefer [GitKracken](https://www.gitkraken.com/) at the moment. It's currently freemium.

* `gs`: `git status`
* `ga`: `git add`
* `gd`: `git diff`
* `gdc`: `git diff --cached`, surprisingly helpful.
* `grm`: `git rm`
* `grc`: `git rm --cached`
* `gc`: `git commit`
* `gl`: like `git log` but much prettier.
* `gpl`: `git pull`
* `gpu`: `git push`
* `gbr`: `git branch -vv` -- verbose branching
* `gcache`: extend credentials timeout to 1 hour (for `gpu`/`gpl`). Useful for when you don't has ssh setup.
