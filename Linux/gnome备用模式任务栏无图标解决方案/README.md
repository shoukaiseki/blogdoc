# gnome备用模式任务栏无图标解决方案

喇叭，网络连接，输入法，电池图标消失
<br />

原先一直使用普通模式的，后来感觉那界面光美观，使用没效率，可是一改为备用模式，任务栏显示为黑黑的一条，本来这个模式应该任务栏是上下各一行的，现在两行重叠在一起了。不过这时候按Alt+F2是能打开终端的，其它也一切正常，后来我就
```Shell
su root
init 3
cd /home/fedora/
ls -a .*
rm -rf .gnome2
init 5
```
进去没效果,
```Shell
su root
init 3
cd /home/fedora/
ls -a .*
rm -rf .gconf
init 5
```
还是没效果
```Shell
su root
init 3
cd /home/fedora/
ls -a .*
rm -rf .config
init 5
```
终于可以了,一直没仔细看,唉大忌啊,这么明显的一个配置目录名,
<br />
不过这里好像存放这该用户有些软件的配置,你可以手动筛选进行删除,当然也可以直接删除整个目录,等会重新配置下了

