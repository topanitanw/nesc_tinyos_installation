# TinyOS and NesC Installation in Ubuntu
# commands and how to install all tools are based on the README files
# kept in the tinyOS and nesc repository
#
# 
# This file is tested to install tinyos and nesc in the Ubuntu 14.04
# The issues that might happen are:
# 1. Cannot make and example projects in the tinyos folder
#    Solution: set the permission of that folder as a root
#
#
# Author: Panitan Wongse-ammat 2/4/2016

cd ~/Download
sudo apt-get update
# add the repositories signing key to APT's keyring.  Needed to verify
# the repository
sudo apt-get -y install emacs24 vim-gnome
# git installation 
sudo apt-get -y install git gitk git-core git-daemon-run git-doc git-email git-gui gitmagic
# Python 2
sudo apt-get -y install build-essential python-dev
sudo apt-get -y install default-jdk
# for anaconda mode in emacs
sudo apt-get -y install python-pip
pip install -U pip setuptools
# TinyOS toolchain & Dependency
sudo apt-get -y install default-jdk build-essential automake bison flex gperf stow automake autoconf libtool libc6-dev
# Tiny OS and Nesc Installation
git clone https://github.com/tinyos/nesc.git
cd /nesc
./Bootstrap
./configure
sudo make
sudo make install
cd ..
# install the tinyOS
git clone https://github.com/tinyos/tinyos-main.git
cd /tinyos-main/tools
./Bootstrap
./configure
sudo make
sudo make install
cd ..

cd ~/Download/tinyos-main/apps/Blink
make telosb
if [ $? -eq 0]; then
    echo "---"
    echo "+++ TinyOS and nesc are installed successfully"
    echo "+++ in the ~/Download/tinyos-main and in the ~/Download/nesc"
else
    echo "---"
    echo "+++ TinyOS is installed unsuccessfully"
fi
