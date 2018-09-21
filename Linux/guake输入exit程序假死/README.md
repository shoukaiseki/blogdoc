# guake输入exit程序假死

##### 问题描述
当我尝试退出shell时（通过按Ctrl-D或键入'exit'）guake冻结选项卡：它不会关闭它，之后有几个失败：比如尝试打开一个新选项卡（Ctrl-Shift-T ），复制和粘贴等...

这个问题在 google搜索输入 “ guake exit  2018" 搜到的

##### 参考来自
https://bugs.launchpad.net/ubuntu/+source/guake/+bug/1760621

https://github.com/Guake/guake/commit/f8699b4be6c058fd58a33a1d783cd404e9076b0e

可以看出 是python代码的缩进造成的

## 解决方案
1420行中

```python
    def on_terminal_exited(self, term, status, widget):
        """When a terminal is closed, shell process should be killed,
        this is the method that does that, or, at least calls
        `delete_tab' method to do the work.
        """
        log.debug("Terminal exited: %s", term)
        if libutempter is not None:
            libutempter.utempter_remove_record(term.get_pty())
		#该行改为向左缩进1格
        self.delete_tab(self.notebook.page_num(widget), kill=False, prompt=False)

```

### linuxmint

```bash
sudo vim /usr/lib/python3/dist-packages/guake/guake_app.py
```



