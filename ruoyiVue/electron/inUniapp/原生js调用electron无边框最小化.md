# 原生js调用electron无边框最小化


## main.js 里面增加配置
```js
    win = new BrowserWindow(
		{
			width: 500,
			height: 427,
			resizable:false,
			frame: !debug,
			pixelRatio: 1.25,
		//设置加载js,将变量注册到d3c 自带变量 windows 中
            webPreferences: {
                nodeIntegration: true,
                preload: __dirname + '/preload.js'
            }
		}
	)
```

## preload.js
```js
window.electronShell=require('electron').shell;

window.globalElectron=require('electron');
```
### js调用方式
调用该段代码就能最小化
```js
window.globalElectron.remote.getCurrentWindow().minimize()
```

### 用浏览器打开链接
```
window.electronShell.openExternal(url);
```

