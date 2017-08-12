# 终端查看实时网速  

Linux想在终端查看实时网速的应该很多吧,毕竟用linux的都是喜欢终端,毕竟图形界面太费内存..

来自  http://bbs.bccn.net/thread-159280-1-0.html shell的脚本

还有一款是iptraf-ng也可以查看,不过太麻烦..没必要
```
#!/bin/bash
#rate -t #实时显示 
#rate   #显示一次
#网卡名需要自定义

HL_START="\033[37;40;1m"
HL_END="\033[0m"
#使用无限网卡自行修改
DEV_NAME="eth0"


function disp_usage()
{
 printf "usage : $1 [DEV_NAME] [ TIMES | -t ]\n\n"
 printf " DEV_NAME the name of the network device, default: eth0\n"
 printf " TIMES the times of counts, default: 1\n"
 printf " -t counting until break\n"



}


if [ $# -eq 0 ]
then
 TOTAL_TIME=1
elif [ $1 == "-h" ]
then
 disp_usage $0
 exit 0
elif [ $1 == "--help" ]
then
 disp_usage $0
 exit 0
elif [ $1 == "-t" ]
then
 TOTAL_TIME=65535
elif [ $# -eq 1 ]
then
 DEV_NAME=$1
 TOTAL_TIME=1
elif [ $2 == "-t" ]
then
 DEV_NAME=$1
 TOTAL_TIME=65535
else
 DEV_NAME=$1
 TOTAL_TIME=$2
fi

echo "the Rate of Network, by dorainm, dora...@gmail.com"
echo "-----------------------------------------------------"


count=0
while [ $count -lt $TOTAL_TIME ]
do
 RX_FIRST=$(/sbin/ifconfig $DEV_NAME | awk '/RX bytes/{print $2}' | awk -F: '{print $2}')
 TX_FIRST=$(/sbin/ifconfig $DEV_NAME | awk '/RX bytes/{print $6}' | awk -F: '{print $2}')
 # echo "FIRST = $FIRST"
 sleep 1
 RX_SECOND=$(/sbin/ifconfig $DEV_NAME | awk '/RX bytes/{print $2}' | awk -F: '{print $2}')
 TX_SECOND=$(/sbin/ifconfig $DEV_NAME | awk '/RX bytes/{print $6}' | awk -F: '{print $2}')
 # echo "SECOND = $SECOND"
 ((RX_FIRST=$RX_SECOND-$RX_FIRST))
 ((TX_FIRST=$TX_SECOND-$TX_FIRST))


 if [ $RX_FIRST -gt 1048576 ]
 then
  RX_FIRST=$(echo "scale=3; $RX_FIRST / 1048576" | bc -l)
  printf "RX Rate = $HL_START%.3F$HL_END MB/S\t" $RX_FIRST
 elif [ $RX_FIRST -gt 1024 ]
 then
  RX_FIRST=$(echo "scale=3; $RX_FIRST / 1024" | bc -l)
  # ((RX_FIRST=($RX_FIRST/1024)))
  printf "RX Rate = $HL_START%.3F$HL_END KB/S\t" $RX_FIRST
 else
  printf "RX Rate = $HL_START$RX_FIRST$HL_END B/S \t"
 fi


 if [ $RX_SECOND -gt 1048576 ]
 then
  RX_SECOND=$(echo "scale=3; $RX_SECOND / 1048576" | bc -l)
  printf "Totle Bytes : $HL_START$RX_SECOND$HL_END MB\n"
 elif [ $RX_SECOND -gt 1024 ]
 then
  RX_SECOND=$(echo "scale=3; $RX_SECOND / 1024" | bc -l)
  printf "Totle Bytes : $HL_START$RX_SECOND$HL_END KB\n"
 else
  printf "Totle Bytes : $HL_START$RX_SECOND$HL_END B\n"
 fi


 if [ $TX_FIRST -gt 1048576 ]
 then
  TX_FIRST=$(echo "scale=3; $TX_FIRST / 1048576" | bc -l)
  printf "TX Rate = $HL_START%.3F$HL_END MB/S\t" $TX_FIRST
 elif [ $TX_FIRST -gt 1024 ]
 then
  TX_FIRST=$(echo "scale=3; $TX_FIRST / 1024" | bc -l)
  printf "TX Rate = $HL_START%.3F$HL_END KB/S\t" $TX_FIRST
 else
  printf "TX Rate = $HL_START$TX_FIRST$HL_END B/S \t"
 fi


 if [ $TX_SECOND -gt 1048576 ]
 then
  TX_SECOND=$(echo "scale=3; $TX_SECOND / 1048576" | bc -l)
  printf "Totle Bytes : $HL_START$TX_SECOND$HL_END MB\n"
 elif [ $TX_SECOND -gt 1024 ]
 then
  TX_SECOND=$(echo "scale=3; $TX_SECOND / 1024" | bc -l)
  printf "Totle Bytes : $HL_START$TX_SECOND$HL_END KB\n"
 else
  printf "Totle Bytes : $HL_START$TX_SECOND$HL_END B\n"
 fi


 ((count=$count+1))
 echo "-----------------------------------------------------"
done


echo "All Done" 
```

