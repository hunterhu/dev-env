#!/bin/bash

pause()
{
    sleep 1
}

echo "============================"
echo "checking /etc/resolv.conf..."
echo "============================"
pause
grep nameserver /etc/resolv.conf
if [ $? -ne 0 ]; then
    sudo echo "nameserver 8.8.8.8" >> /etc/resolv.conf
fi

echo "============================"
echo "Adjust sudo timeout ..."
echo "============================"
pause
sudo sed -i 's/Defaults.*env_reset.*/Defaults    env_reset,timestamp_timeout=-1/' /etc/sudoers

echo "============================"
echo "Remove Ubuntu Error Report ..."
echo "============================"
pause
sudo apt-get purge apport

echo "============================"
echo "Purge packages ..."
echo "============================"
PURGES=( libreoffice* thunderbird )
for p in "${PURGES[@]}"
do
     echo "======================"
     echo "Purging $p ..."
     echo "======================"
     pause
     sudo apt-get remove --purge $p
done
sudo apt-get clean
sudo apt-get autoremove

echo "================================"
echo "sudo apt-get update/upgrade..."
echo "================================"
pause
sudo apt-get update
sudo apt-get upgrade

echo "================================"
echo "Installing essential packages..."
echo "================================"
pause
PACKAGES=( python3-dev cmake curl nfs-common nmap vbindiff bless cscope
exuberant-ctags ctags git gitk openssh openssh-server tree meld vim ntp
build-essential ack-grep htop qemu-user-static minicom vim-gtk
linux-tools-common inotify-tools libc6-dev-i386 libxcb-xinerama0 lsd neofetch
cpufetch cmatrix bpytop ddd tmux ncdu neovim tilix)
for i in "${PACKAGES[@]}"
do
     echo "======================"
     echo "Installing $i ..."
     echo "======================"
     pause
     sudo apt-get install $i -y
done

echo "================================"
echo "Installing Yocto required packages..."
echo "================================"
pause
PACKAGES=( chrpath gawk texinfo bmap-tools )
for i in "${PACKAGES[@]}"
do
     echo "======================"
     echo "Installing $i ..."
     echo "======================"
     pause
     sudo apt-get install $i -y
done

echo "================================"
echo "Installing arm dev packages..."
echo "================================"
pause
DEV_PACKAGES=( libssl-dev liblzma-dev ld-essential u-boot-tools
gcc-arm-linux-gnueabihf libusb-1.0-0-dev wget fakeroot kernel-package zlib1g-dev
libncurses5-dev zlib1g:i386 lib32z1 lzop gettext)
for i in "${DEV_PACKAGES[@]}"
do
     echo "=============================="
     echo "Installing $i ..."
     echo "=============================="
     pause
     sudo apt-get install $i -y
done

echo "================================"
echo "Setting vim as system editor ..."
echo "================================"
pause
sudo update-alternatives --config editor

echo "============================="
echo "Setting up development env..."
echo "============================="
pause
echo "====================="
echo "Installing .bashrc..."
echo "====================="
pause
cp bash/dot_bashrc ~/.bashrc
source ~/.bashrc

echo "========================"
echo "Installing .gitconfig..."
echo "========================"
pause
cp git/dot_gitconfig ~/.gitconfig

echo "===================="
echo "Installing .vimrc..."
echo "===================="
pause
cp vim/dot_vimrc_ubuntu ~/.vimrc

echo "=================="
echo "Installing .vim..."
echo "=================="
pause
tar jxf vim/dot_vim_ubuntu.tar.bz2 -C vim/
cp -R vim/dot_vim_ubuntu ~/.vim

echo "=================="
echo "Installing .tmux.conf..."
echo "=================="
pause
cp tmux/dot_tmux.conf ~/.tmux.conf

mkdir ~/bin
cp drop_fs_caches.sh ~/bin/

sudo apt-get autoremove

echo "DONE"
