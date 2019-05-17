# maven 命令行自动补全

#### 官方方案 

-T 4 是直接指定4线程 

-T 1C 表示CPU线程的倍数 

```
mvn  -T 1C -Dmaven.compile.fork=true clean deploy -Dmaven.test.skip=true -U
```
