## terminalrc

This is how I setup my terminal. It currently supports bash and zsh on Linux and [Cygwin](https://www.cygwin.com/ "Cygwin").

### Prerequisites

All you need is bash, git, and python 2 or 3 (for the installation script). I assume you have a decent .bashrc that colorizes your command line which you wish to extend without modifying too much.

### Installation

Install on bash with:

```bash
$ cd ~
$ git clone https://github.com/vguarnaccia/.terminalrc.git
$ python ~/.terminalrc/installer.py --install bashrc
$ source ~/.bashrc
```

Uninstall bash config with:

```bash
$ python ~/.terminalrc/installer.py --remove bashrc
```
And then delete `.terminalrc/`

For zsh, follow the instructions above but replace bashrc with zshrc.

### Extendible

If you need any local configurations, you can add them to `~/.terminalrc/local`. This way they are read when using bash or zsh.

### Platforms

I've tested it on [Ubuntu](http://releases.ubuntu.com/16.04/ "Ubuntu"), [Arch](https://www.archlinux.org/) and [Cygwin](https://www.cygwin.com/ "Cygwin"). It *should* also work on Mac, where it installs the script on `.bash_profile` instead of `.bashrc`.

### Bash Features

* Each time you open a new bash terminal, a quick description of a random
* command will print. There's room for improvement on that feature but it's a good way to learn about more obscure commands.
* Smart Autocomplete: case-insensitive autocomplete for directories and git autocomplete.
* Colorized prompt, manpages and commands.
* `extract` command which will try to decompress various archive types.

#### Extended Navigation Commands

* `l`: Horizontally list content (`ls -CF`).
* `ll`: Vertically list content (`ls -AhlF`).
* `cdl`: Change directory and list contents.
* `mkcd`: Make directory and enter it.

### Unwarranted Suggestions

1. Replace `ls` with [exa](https://the.exa.website/). See the example local file for aliases.
2. Instead of using `ls` and `cd` everywhere when trying to understand a directory, use the `tree` command or `exa`.
3. When moving to a new directory, use [autojump](https://github.com/wting/autojump "autojump") instead of `cd`. 
4. [Silver Searcher](https://github.com/ggreer/the_silver_searcher "Silver Searcher") can be used in place of most `find`, `xargs`, `grep` combos. 
5. `locate` is superior to `find` if the file you are looking for is a least a day old.
6. If you like to use `less` instead of cat, as I do, consider install first 
[lesspipe.sh](https://www-zeuthen.desy.de/~friebel/unix/lesspipe.html), then
[pygmentize](http://pygments.org/docs/cmdline/).
This will enable source code highlighting and archive inspecting.

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
