# https-nginx


```shell
#!/bin/bash - 
#===============================================================================
#
#          FILE: creteHttpsKey.sh
# 
#         USAGE: ./creteHttpsKey.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2021年02月22日 22时05分40秒
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error

 pwd=123456
 #生成的名称
 name="test6.shoukaiseki.cn"
 tmpPath=$(cd "$(dirname "$0")"; pwd) 
 echo "tmpPath ${tmpPath}"
 echo $0

echo 生成jks
rm -Rf  jks
mkdir jks
cd jks
keytool -genkeypair -alias $name -keystore $name.jks -storetype pkcs12 -keypass $pwd -storepass $pwd  -keyalg RSA -keysize 2048 -validity 365 -dname "CN=http://test6.shoukaiseki.cn,OU=xx，O=dy, L=nb,ST=zj,C=china"

keytool -exportcert -keystore $name.jks -file $name.cer -alias $name -storepass $pwd
cd ${tmpPath}
pwd

echo "转换jks->pfx"
rm -Rf  pfx
mkdir pfx
keytool -importkeystore -srckeystore $tmpPath/jks/$name.jks -destkeystore $tmpPath/pfx/$name.pfx -srcstoretype PKCS12 -deststoretype PKCS12 -srcstorepass $pwd -deststorepass $pwd

cd ${tmpPath}
pwd


echo "转换pfx->pem/key"
rm -Rf pem
mkdir pem
openssl pkcs12 -in $tmpPath/pfx/$name.pfx -nodes -out $tmpPath/pem/$name.pem -password pass:$pwd
openssl rsa -in $tmpPath/pem/$name.pem -out $tmpPath/pem/$name.key
cd ${tmpPath}
keytool -list -v -keystore $tmpPath/jks/$name.jks -storepass $pwd

```
