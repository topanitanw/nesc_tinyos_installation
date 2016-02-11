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
sudo -s
apt-get update
# add the repositories signing key to APT's keyring.  Needed to verify
# the repository
wget -O - http://tinyprod.net/repos/debian/tinyprod.key |  apt-key add -
apt-get install emacs24 vim-gnome
apt-get install build-essential stow automake autoconf libtool libc6-dev
# git installation 
apt-get install git gitk git-core git-daemon-run git-doc git-email git-gui gitmagic
# TinyOS toolchain & Dependency
apt-get install default-jdk build-essential automake bison flex gperf git stow automake autoconf libtool libc6-dev
apt-get install openssh-client openssh-server
apt-get install python3 python3-serial python python-serial
echo "deb http://tinyprod.net/repos/debian squeeze main"   >> /etc/apt/sources.list.d/tinyprod-debian.list
echo "deb http://tinyprod.net/repos/debian msp430-46 main" >> /etc/apt/sources.list.d/tinyprod-debian.list
apt-get update
apt-get install nesc tinyos-tools msp430-46 mspdebug
cd /opt
# install the nesc
git clone https://github.com/tinyos/nesc.git
cd /nesc
chmod 777 .
./Bootstrap
./configure
make
make install
# install the tinyOS
git clone -o tos -v git://github.com/tinyos/tinyos-main tinyos-2.x
cd /opt/tinyos-2.x
chmod 777 .
cd /opt/tinyos-2.x/tools
./Bootstrap
./configure
make
make install
cd ~
echo ""
echo "TinyOS Installation"
echo "MOTECOM=\"serial@/dev/ttyUSB0:telosb\"" >> .bashrc
echo "TOSROOT=~/top/t2_cur/tinyos-2.x" >> .bashrc
echo "TOSDIR=$TOSROOT/tos" >> .bashrc
echo "MAKERULES=$TOSROOT/support/make/Makerules" >> .bashrc
echo "CLASSPATH=.:$TOSROOT/support/sdk/java/tinyos.jar" >> .bashrc
echo "PYTHONPATH=$TOSROOT/support/sdk/python:$PYTHONPATH" >> .bashrc
echo "export MAKERULES TOSDIR TOSROOT CLASSPATH PYTHONPATH" >> .bashrc
echo "export MOTECOM" >> .bashrc
source ~/.bashrc
cd /opt/tinyos-2.x/apps/Blink
chmod 777 .
make telosb
if [ $? -eq 0]; then
    echo "---"
    echo "+++ TinyOS and nesc are installed successfully"
    echo "+++ in the /opt/tinyos-2.x and in the /opt/nesc"
else
    echo "---"
    echo "+++ TinyOS is installed unsuccessfully"
fi
