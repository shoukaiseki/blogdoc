# ideajvm
## IDEA配置
### 方案1
```
-Xms8g
-Xmx8g
-XX:ReservedCodeCacheSize=2g
-XX:NewRatio=3
-Xss16m
-XX:ConcGCThreads=4
-XX:+UseCompressedOops
-XX:+UseG1GC
-XX:SoftRefLRUPolicyMSPerMB=5000
-XX:CICompilerCount=2
-XX:+HeapDumpOnOutOfMemoryError
-XX:-OmitStackTraceInFastThrow
-ea
-Dsun.io.useCanonCaches=false
-Djdk.http.auth.tunneling.disabledSchemes=""
-Djdk.attach.allowAttachSelf=true
-Djdk.module.illegalAccess.silent=true
-Dkotlinx.coroutines.debug=off
-Dsun.tools.attach.tmp.only=true
-Dfile.encoding=UTF-8
```

### 网上建议
#### 网上建议1
```
-server
-Xms2g
-Xmx2g
-XX:NewRatio=3
-Xss16m
-XX:+UseConcMarkSweepGC
-XX:+CMSParallelRemarkEnabled
-XX:ConcGCThreads=4
-XX:ReservedCodeCacheSize=240m
-XX:+AlwaysPreTouch
-XX:+TieredCompilation
-XX:+UseCompressedOops
-XX:SoftRefLRUPolicyMSPerMB=50
-Dsun.io.useCanonCaches=false
-Djava.net.preferIPv4Stack=true
-Djsse.enableSNIExtension=false
-ea
```
## JVM参数
### XX:SoftRefLRUPolicyMSPerMB
触发垃圾回收的毫秒数
-XX:SoftRefLRUPolicyMSPerMB=N 这个参数比较有用的，官方解释是：Soft reference在虚拟机中比在客户集中存活的更长一些。其清除频率可以用命令行参数 -XX:SoftRefLRUPolicyMSPerMB=<N>来控制，这可以指定每兆堆空闲空间的 soft reference 保持存活（一旦它不强可达了）的毫秒数，这意味着每兆堆中的空闲空间中的 soft reference 会（在最后一个强引用被回收之后）存活1秒钟。注意，这是一个近似的值，因为  soft reference 只会在垃圾回收时才会被清除，而垃圾回收并不总在发生。系统默认为一秒，我觉得没必要等1秒，客户集中不用就立刻清除，改为 -XX:SoftRefLRUPolicyMSPerMB=0；

#### 网上建议
有大量反射代码的场景下，大家只要把
-XX:SoftRefLRUPolicyMSPerMB=0

这个参数设置大一些即可，千万别让一些新手同学设置为0，可以设置个1000，2000，3000，或者5000毫秒，都可以。
