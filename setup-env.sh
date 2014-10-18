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
PACKAGES=( cscope ctags git gitk openssh tree meld vim chromium-browser ntp
ack-grep htop qemu-user-static )
for i in "${PACKAGES[@]}"
do
     echo "======================"
     echo "Installing $i ..."
     echo "======================"
     pause
     sudo apt-get install $i -y
done

echo "================================"
echo "Installing sunxi dev packages..."
echo "================================"
pause
DEV_PACKAGES=( ld-essential u-boot-tools gcc-arm-linux-gnueabihf libusb-1.0-0-dev wget fakeroot kernel-package zlib1g-dev libncurses5-devr )
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
cp -R vim/dot_vim_ubuntu ~/.vim

echo "DONE"
