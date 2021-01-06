# OSS对象存储服务

进入OSS对象存储服务页面 https://oss.console.aliyun.com/?userCode=tc3gyred

![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/001.png)

### 点击 "立即开通"

![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/002.png)

勾选 "我已阅读并同意 对象存储OSS 服务协议" 之后点击 "立即开通"

重新进入 https://oss.console.aliyun.com/?userCode=tc3gyred 页面


### 点击 "创建Bucket"

![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/003.png)


"Bucket 名称" 随意取,地域根据自己所在城市挑选最近的,其它按照图片中的选项选择

![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/004.png)

#### 点击确定之后截取访问信息发给开发人员

例如:
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/005.png)


## 访问密钥创建
wb-testoss
### 点击右上角头像,选择访问控制
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/006.png)

#### 点击"权限策略管理"->"创建权限策略"

![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/007.png)

策略名称可以随意起,内容如下,将其中的 wb-testoss 改成你之前创建的 "Bucket"名称即可
```json
{
	"Version": "1",
		"Statement": [
		{
			"Effect": "Allow",
			"Action": [
				"oss:ListObjects",
			"oss:PutObject",
			"oss:GetObject"
			],
			"Resource": [
				"acs:oss:*:*:wb-testoss", 
			"acs:oss:*:*:wb-testoss/*"
			]
		}
		]
}
```
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/008.png)

点击确认之后返回

#### RAM角色管理->创建RAM角色

 选择阿里云帐号,点击下一步
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/009.png)

角色名称随意填写, "选择云帐号"选择当前云帐号
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/010.png)

之后点击"为角色授权","授权范围"选择"云帐号全部资源",
选择权限,选系统策略,搜索sts,将 AliyunSTSAssumeRoleAccess 策略名称选上
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/012.png)
选择权限,选自定义策略中之前新增的策略选上.
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/011.png)
之后点击确定->完成

再在 RAM角色管理 列表中点击你创建的角色,点击 ARN 右边的复制,将内容发给 开发人员

![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/013.png)

#### 点击左边菜单栏"用户",然后 创建用户
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/014.png)

"登录名称"和"显示名称" 随意填写,勾选编程访问之后点击确定
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/015.png)
点击复制之后将内容发给开发人员
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/016.png)

```
用户登录名称 wb-testoss-user@1072793340375288.onaliyun.com
AccessKey ID LTAI4G6sEQTsZAXggdCUDHKA
AccessKey Secret 03uAygpYWdrLFPaOIxWw5SaF9R3bWc
```
再点击左边菜单栏"用户",点击用户列表中刚才建立的用户,点击"权限管理"标签页
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/017.png)

添加权限 
选系统策略,搜索sts,将 AliyunSTSAssumeRoleAccess 策略名称选上
选择权限,选自定义策略中之前新增的策略选上.
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/018.png)



#### 最后设置
重新进入 https://oss.console.aliyun.com/?userCode=tc3gyred 页面
左边菜单栏选择"Bucket列表",Bucket列表中点击之前创建的名称
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/019.png)

点击"新建目录",目录名可以随意起,但是不要包含中文,之后告诉开发人员即可
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/020.png)

再点击左边菜单栏"权限管理","跨域设置"
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/021.png)
跨域设置下面的设置点击下
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/022.png)

点击创建规则,按照下图设置即可
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/OSS%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1/img/023.png)
##### 需要设置的内容可以直接复制进行粘贴
来源
```
http://*
```
允许 Headers
```
*
```
暴露 Headers
```
ETag
x-oss-request-id
```
