#!/bin/bash - 
#===============================================================================
#
#          FILE: install-tools.sh
# 
#         USAGE: ./install-tools.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2021年01月30日 16时45分29秒
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

if [ ! -d "/data" ]; then
	mkdir /data
fi
if [ ! -d "/data/usr" ]; then
	mkdir /data/usr
fi
if [ ! -d "/tmp/win" ]; then
	mkdir /tmp/win
fi
cd /tmp/win
wget https://ranger.github.io/ranger-1.9.3.tar.gz
tar zxvf ranger-1.9.3.tar.gz
mv ranger-1.9.3 /data/usr
ln -s /data/usr/ranger-1.9.3/ranger.py /bin/ranger

wget http://asus88.vicp.net:9000/vim/vimconf.tar.gz
tar zxvf vimconf.tar.gz
cp -r vimconf/. /root
wget http://asus88.vicp.net:9000/vim/molokai.vim

if [ -d "/usr/share/vim/vim74" ]; then
	if [ ! -f "/usr/share/vim/vim74/colors/molokai.vim" ]; then
		cp molokai.vim /usr/share/vim/vim74/colors/molokai.vim
	fi
fi

if [ -d "/usr/share/vim/vim80" ]; then
	if [ ! -f "/usr/share/vim/vim80/colors/molokai.vim" ]; then
		cp molokai.vim /usr/share/vim/vim80/colors/molokai.vim
	fi
fi
