
## 安装rabbitvcs
sudo apt search rabbitvcs

```
sudo apt install rabbitvcs-cli rabbitvcs-core rabbitvcs-gedit rabbitvcs-nautilus
```
### 下载源码安装
```
git clone https://github.com/rabbitvcs/rabbitvcs.git
cd rabbitvcs
python setup.py install --install-layout=deb

```

```shell
cd clients
cd caja
cp RabbitVCS.py /usr/share/caja-python/extensions/RabbitVCS.py
```

### 安装完成之后重启caja即可

```shell
caja -q
nohup caja > /dev/null &
```


#### 没用该方式
https://www.cnblogs.com/bamanzi/archive/2012/07/08/rabbitvcs-gnome3-mate.html
```
apt-get install rabbitvcs-nautilus
sudo apt-get install rabbitvcs-core
```

