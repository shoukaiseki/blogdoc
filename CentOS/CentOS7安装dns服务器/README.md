# CentOS7安装dns服务器





## 配置

/etc/named.rfc1912.zones

```named
// named.rfc1912.zones:
//
// Provided by Red Hat caching-nameserver package 
//
// ISC BIND named zone configuration for zones recommended by
// RFC 1912 section 4.1 : localhost TLDs and address zones
// and http://www.ietf.org/internet-drafts/draft-ietf-dnsop-default-local-zones-02.txt
// (c)2007 R W Franks
// 
// See /usr/share/doc/bind*/sample/ for example named configuration files.
//

zone "localhost.localdomain" IN {
	type master;
	file "named.localhost";
	allow-update { none; };
};

zone "localhost" IN {
	type master;
	file "named.localhost";
	allow-update { none; };
};

zone "1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa" IN {
	type master;
	file "named.loopback";
	allow-update { none; };
};

zone "1.0.0.127.in-addr.arpa" IN {
	type master;
	file "named.loopback";
	allow-update { none; };
};

zone "0.in-addr.arpa" IN {
	type master;
	file "named.empty";
	allow-update { none; };
};



zone "test123.com" IN {
	type master;
	file "test123.com.zone";
	allow-update { none; };
};

zone "jenkins.hkedou.com" IN {
	type master;
	file "jenkins.hkedou.com.zone";
	allow-update { none; };
};


zone "devhkedou.com" IN {
	type master;
	file "devhkedou.com.zone";
	allow-update { none; };
};
```


[root@localhost ~]# cat /var/named/devhkedou.com.zone
```named
$TTL 1D
@	IN SOA @	devhkedou.com.zone. (
					18092501 ; serial
					1D	; refresh
					1H	; retry
					1W	; expire
					3H )	; minimum
	NS	@
	A	192.168.0.200
jenkins IN A 192.168.0.200
dubboadmin IN A 192.168.0.200
eureka-server IN A 192.168.0.200
eureka-center IN A 192.168.0.200
mysql-db IN A 192.168.0.198
www IN A 192.168.0.200
```


[root@localhost ~]# cat /var/named/devhkedou.com.local
```named
$TTL 1D
@	IN SOA 	devhkedou.com. rname.invalid. (
					18092502 ; serial
					1D	; refresh
					1H	; retry
					1W	; expire
					3H )	; minimum
	NS	@
	A	192.168.0.200
200 IN PTR eureka-server
200 IN PTR dubboadmin
200 IN PTR eureka-server
200 IN PTR eureka-center
198 IN PTR mysql-db
```


[root@localhost ~]# cat /var/named/test123.com.zone

```named
$TTL 1D
;@ORIGIN test123.com
@	IN SOA @	test123.com. (
					18092002	; serial
					1D	; refresh
					1H	; retry
					1W	; expire
					3H )	; minimum
	NS	@
	A	192.168.0.200
sys IN A 192.168.0.200
www IN A 192.168.0.200
	;AAAA	::1
```


[root@localhost ~]# cat /var/named/jenkins.hkedou.com.zone
```named
$TTL 1D
@	IN SOA	@ rname.invalid. (
					18092001 ; serial
					1D	; refresh
					1H	; retry
					1W	; expire
					3H )	; minimum
	NS	@
	A	192.168.0.200
sys IN A 192.168.0.200
```
