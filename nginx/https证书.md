#

## linux mint

### 安装
https://www.cnblogs.com/fundebug/p/apply-lets-encrypt-certificate.html
```
sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository -y ppa:certbot/certbot
sudo apt-get update
sudo apt-get install -y python3-certbot-nginx
```
### 生成证书
```
sudo certbot --nginx -d gitlab.shoukaiseki.cn -n --email jiang28555@gmail.com --agree-tos
```
HTTPS 证书相关的文件在 /etc/letsencrypt/ 目录中
