# eclipse无法运行class,不自动编译  

当保存之后没有编译class文件,

1.勾选上project->build automatically；

设置JDK

2.window -> preference -> java -> install jres -> add -> standard vm -> 设置好相应的jre home

转自:http://hi.baidu.com/niuhea/blog/item/f68c1daf991348ebfbed50de.html
   有时候用Eclipse或MyEclipse的时候，发现不能自动编译，web工程下面缺少class文档！

    第一个可能是您的自动编译没打开：project->build automatically；第二个要注意您的工程项目上有没有打小红叉，项目报错时，eclipse是不自动编译的。您能够检查一下是否有些类出错，或 是检查一下“构建路径”是否完整，特别是从换机子调试程式时，有些导入jar包的路径不对。

    通常我们碰到的是第二个，就是有的包在别人机器上是有的，但是到您的机器上相同路径是没有的，删去和那个包有关系的，或添加新的包路径

    eclipse出现不编译工程的现象。怎么刷新classes目录下也是空的。

    具体都操作了：打开project->build automatically   试后不行，还是不编译。

    打开project ――> build automatically 另外 clean一下就可能会编译了，结果还不行。（一般先运行project ――>clean…，然后再执行build automatically）

    eclipse默认是选自动编译。即使取消自动编译，手动build工程，也不能编译。

    出现这种情况一般有以下几种原因：1.假如项目里引了某个不用的jar包，而那个包又被您删了，就会出现不报错但怎么也编译不出来class文档的情况， 能够把任何包都删除，然后一个一个的再引入（需要的），不要一下子把任何包都引入来，没用的可能会引起不良后果。

    2.想删掉某个class文档重新生成，删除class文档后，但classes目录下的文档夹被其他程式打开，比如Total Commander.此时编译也不会通过，在problems下可能会提示“con't delete classes ……”。关掉其他程式重新编译即可。

    3.更有种情况是remove掉 JRE System Library，重新导入即可编译。但是什么原因导致的还不清楚。

    4.项目引用了其他的项目，而被您引用的项目引用了某个不用的jar包之类

    假如您使用了maven您能够在命令提示行下，跳转到项目路径，执行mvn eclipse：clean eclipse：eclipse重新编译项目
