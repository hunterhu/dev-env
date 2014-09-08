#!/bin/bash

echo "checking /etc/resolv.conf..."
grep nameserver /etc/resolve.conf
if [ $? -ne 0 ]; then
    echo "nameserver 8.8.8.8" >> /etc/resolve.conf
fi

echo "Installing essential packages..."
PACKAGES=( cscope ctags git gitk openssh tree )
for i in "${PACKAGES[@]}"
do
     echo "Installing $i ..."
     sudo apt-get install $i -y
done

echo "Setting up development env..."
echo "Installing .bashrc..."
cp bash/dot_bashrc ~/.bashrc
source ~/.bashrc

echo "Installing .gitconfig..."
cp git/dot_gitconfig ~/.gitconfig

echo "Installing .vimrc..."
cp vim/dot_vimrc_ubuntu ~/.vimrc

echo "Installing .vim..."
cp vim/dot_vim_ubuntu ~/.vim
