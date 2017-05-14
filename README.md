## terminlrc
This is how I setup my terminal. It currently supports bash and should work on cygwin. I plan to add fish as I use it more.

Install with:

    git clone https://github.com/vguarnaccia/terminalrc.git ~/.terminalrc/
    python ~/.terminalrc/installer.py
    source ~/.bashrc
    
This install script works with python 2.7 or higher.
    
Uninstall with:

    python ~/.terminalrc/installer.py --remove bashrc

And then delete .terminalrc
