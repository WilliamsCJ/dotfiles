#!/bin/bash

# Install chezmoi
sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply WilliamsCJ

# Install macos specific
[[ $OSTYPE == 'darwin'* ]] && echo /bin/bash .macos.sh
