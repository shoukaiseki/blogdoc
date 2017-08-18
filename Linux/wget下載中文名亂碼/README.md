# wget下載中文名亂碼  


轉發地址:http://hi.baidu.com/sdusoul/blog/item/7efee1fac8fe6915a9d31129.html

### wget下載中文名亂碼
源碼下載地址: ftp://ftp.gnu.org/gnu/wget/

更改src目錄下的url.c源碼

#### 將
```
#define FILE_CHAR_TEST(c, mask) \
    ((opt.restrict_files_nonascii && !c_isascii ((unsigned char)(c))) || \
 (filechr_table[(unsigned char)(c)] & (mask)))
```
#### 更改爲
```
#define FILE_CHAR_TEST(c, mask) \
    ((opt.restrict_files_nonascii && !c_isascii ((unsigned char)(c))) || \
    (filechr_table[(unsigned char)(c)] & (mask)) \
 && !((c|0x0fffffff) == 0xffffffff)) /*排除中文*/
```

