# 字典默认存放路径

IDEA dictionary save user.home

默认 alt+Enter 的提示是 Save 'xxx' to project-level dictionary 存放在项目字典库中

虽然可以在该选项按右箭头选择 Fix all 'Typo' problems in file 存放到全局字典库,但是这样很不方便

要将其默认选项存放到用户下面的字典库,只需在 setting 中设置

搜索 project-level 

在 Editor->Spelling-> Dictionaries->Advanced settings 的 Use single dictionary for saving words 勾上,选择 application-level 即可

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/idea/%E5%AD%97%E5%85%B8%E9%BB%98%E8%AE%A4%E5%AD%98%E6%94%BE%E8%B7%AF%E5%BE%84/img/001.png)


下次默认 alt+Enter 的提示是 Save 'xxx' to application-level dictionary 

dictionary 存放路径

```
# 添加后idea会有缓存,不会实时更新到该文件中,但是在 Setting 中打开编辑是能直接看到最新的
 ~/.IntelliJIdea2018.2/config/options/cachedDictionary.xml

.idea/dictionaries/
```
