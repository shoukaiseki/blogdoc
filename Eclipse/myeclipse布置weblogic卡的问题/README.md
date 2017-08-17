# myeclipse布置weblogic卡的问题 

Windows->Preferences->Myeclipse->Servers->WebLogic->WebLogic9.x->JDK
```
-Xms256m -Xmx512m -XX:CompileThreshold=8000 -XX:PermSize=32m -XX:MaxPermSize=128m -Xverify:none -da
```
将-Xms256m -Xmx512m改成-Xms64m -Xmx216m 

```
-Xms64m -Xmx216m -XX:CompileThreshold=8000 -XX:PermSize=32m -XX:MaxPermSize=128m -Xverify:none -da
```


