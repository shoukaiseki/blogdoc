# 触发远程构建

## 1. 任务配置中启用 构建触发器->触发远程构建 (例如,使用脚本),身份验证令牌输入:test
虽然说明写着通过访问url:JENKINS_URL/job/test1/build?token=TOKEN_NAME,进行触发构建,但是会出现403重定向错误

因为该功能已经在几年前被弃用

官方文档: https://issues.jenkins-ci.org/browse/JENKINS-17764

解决方案:https://wiki.jenkins.io/display/JENKINS/Build+Token+Root+Plugin


## 2. 安装插件 Build Authorization Token Root

## 3. 安装完插件访问方式

```
JENKINS_URL/buildByToken/build?job=RevolutionTest&token=test


JENKINS_URL/buildByToken/buildWithParameters?job=RevolutionTest&token=test&Type=Mexican
```
