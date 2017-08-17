# ibus 修复加入启动项  

Ibus如果始終顯示在左下角,不跟隨光標則加入以下項

#ibus在 ~/.bashrc加入以下内容 
```Shell

export GTK_IM_MODULE=ibus 

export XMODIFIERS=@im=ibus 

export QT_IM_MODULE=ibus
```
然後註銷,當然也可以以該用戶執行以下命令載入新增你的環境變量重啓ibus
```Shell
source ~/.bashrc
ibus exit

ibus-daemon -d
```

 不過只在這個終端有效,因爲只有這個終端擁有新增的環境變量.

修改爲豎直排列,在首選項中的"常規"修改後還要在"輸入法"的相應"輸入法中"修改,需重啓ibus
