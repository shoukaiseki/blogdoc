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
# 有的版本不支持,使用下面的方式
#zypper install ranger -y


URL_PATH="https://wb-test-apk.oss-cn-hangzhou.aliyuncs.com/server"


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
#wget https://ranger.github.io/ranger-1.9.3.tar.gz
wget $URL_PATH/aliyun/ranger-1.9.3.tar.gz
tar zxvf ranger-1.9.3.tar.gz
mv ranger-1.9.3 /data/usr
ln -s /data/usr/ranger-1.9.3/ranger.py /bin/ranger
echo '如果ranger 运行不了,则修改pranger.py 将第一行的python改成 python3即可'

wget $URL_PATH/vim/vimconf.tar.gz
tar zxvf vimconf.tar.gz
cp -r vimconf/. /root
wget  $URL_PATH/vim/molokai.vim
if [ ! -f "/usr/share/vim/vim74/colors/molokai.vim" ]; then
	cp molokai.vim /usr/share/vim/vim74/colors/molokai.vim
fi
