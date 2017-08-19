# ln遞歸子目錄建立硬連接

ln遞歸子目錄建立硬連接

```Bash
#!/bin/bash - 
#===============================================================================
#
#          FILE: rsync.sh
# 
#         USAGE: ./rsync.sh
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2012年06月19日 13时10分42秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
#source=/media/linux/data/maximo/workspace/BIRTCLASS/bin/com/shuto
source=/media/linux/data/maximo/workspace/BIRTCLASS/bin/com
destination=/media/linux/data/opt/tomcat/webapps/birt/WEB-INF/classes/com
test=/tmp/del/del/
#rm -rf $destination
#rsync -av --recursive --times --links --delete --exclude="*~"  $source/ $destination
#rsync -av  --recursive --link-dest=$test --times --perms --links --delete  $source $destination
#rsync --delete -avcp  --exclude="*~"  $source $destination
#rsync --delete -av  --exclude="*~"  $source $destination

#echo ln -f  $source"/shuto/birt/*" $destination/shuto/birt/
#ln -f  $source/shuto/birt/* $destination/shuto/birt/
#mount --bind  $source $destination

echo 進行遞歸建立硬連接
find $source -type d |
while read LINE 
do 
 new=${LINE/$source/$destination}
 if [ ! -x $new ]
 then
  mkdir -p $new
  echo 創建目錄$new
 fi 
 echo "sh=ln - f $LINE/* $new/"
 ln -f $LINE/* $new/
done


```


