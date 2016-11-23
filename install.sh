#!/bin/bash
echo 'if [ -f ~/.bashrc ]; then
    for f in ~/.terminalrc/terminalrcs/*; do
        source $f
    done
fi' >> ~/.bashrc
