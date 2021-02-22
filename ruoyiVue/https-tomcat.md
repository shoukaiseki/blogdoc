# https-tomcat

```
http://www.micmiu.com/lang/java/keytool-start-guide/
http://www.cnblogs.com/xwdreamer/p/3466661.html
			   	<Connector port="8443" protocol="HTTP/1.1" SSLEnabled="true"
               maxThreads="150" scheme="https" secure="true"
               clientAuth="false" sslProtocol="TLS" keystoreFile="D:/tomcat.keystore" keystorePass="123456"/>

keytool -genkeypair -alias "tomcat" -keyalg "RSA" -keystore "D:\tomcat.keystore"

密钥库口令:123456（这个密码非常重要）
名字与姓氏:192.168.1.118（以后访问的域名或IP地址，非常重要，证书和域名或IP绑定）
组织单位名称:dunan（随便填）
组织名称:dunan（随便填）
城市:dunan（随便填）
省市自治区:dunan（随便填）
国家地区代码:dunan（随便填）



keytool -genkeypair -alias "tomcat" -keyalg "RSA" -keystore "D:\tomcat.keystore" -storepass 123456 -dname "CN=192.168.1.106,OU=dunan,O=dunan,L=dunan 称,ST=dunan,C=ZH" -keypass 123456

密钥库口令:123456（这个密码非常重要）
名字与姓氏:192.168.1.118（以后访问的域名或IP地址，非常重要，证书和域名或IP绑定）
组织单位名称:dunan（随便填）
组织名称:dunan（随便填）
城市:dunan（随便填）
省市自治区:dunan（随便填）
国家地区代码:dunan（随便填）

导出证书
keytool -export -trustcacerts -alias "tomcat" -file "D:\tomcat.cer" -keystore "D:\tomcat.keystore" -storepass 123456

keytool -export -trustcacerts -alias "tomcat" -file "C:\del\dunan\192.168.1.118tomcat.cer" -keystore "C:\del\dunan\192.168.1.118tomcat.keystor" -storepass 123456

```
