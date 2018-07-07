#!/bin/bash

cp ./.clang-format ~/
mkdir -p ~/.config/nvim
cp ./init.vim  ~/.config/nvim/
cp ./init.vim ~/.vimrc

cp config.fish ../../.config/fish/config.fish

sudo cp bin/* /usr/local/bin/
