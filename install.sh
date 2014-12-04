#!/bin/sh

# install neobundle: works on Unix and OSX
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
cp -i vimrc ~/.vimrc
cp -i utils.vim ~/.vim/
