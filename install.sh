#!/bin/bash
echo "if [ -f ~/.bashrc ]; then
    for f in ~/.terminalrcs/*; do
        source $f
    done
fi" >> ~/.bashrc
source ~/.bashrc
