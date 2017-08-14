# 批量重命名

```Bat
@echo off&setlocal EnableDelayedExpansion

set /a a=1
set  b=00!a!
echo b=%b%  
pause
for /f "delims=" %%i in ('dir /b *.jpg') do (
if not "%%~ni"=="%~n0" (
ren "%%i" "2011Y11M11D!b!.jpg"
echo ren "%%i" "2011Y11M11D!b!.jpg"
rem 文件名为2011Y11M11D编号
set /a a+=1


if !a! lss 100 (
if !a! lss 10 (
set  b=00!a!
echo b=!b!    "a<10" 
) else (
set b=0!a!
echo b=!b!     "a<100" 
)
) 
rem 变量a+1
))
rem 这句是注释,执行后没效果
echo 批量改名完成
pause

goto start
      = EQU - 等于
      = NEQ - 不等于
      = LSS - 小于
      = LEQ - 小于或等于
      = GTR - 大于
      = GEQ - 大于或等于
:start
@echo off&setlocal EnableDelayedExpansion
set /a a=1
set  b=00!a!
echo b=%b%  
pause
for /f "delims=" %%i in ('dir /b *.jpg') do (
if not "%%~ni"=="%~n0" (
ren "%%i" "2011Y11M11D!b!.jpg"
echo ren "%%i" "2011Y11M11D!b!.jpg"
rem 文件名为2011Y11M11D编号
set /a a+=1


if !a! lss 100 (
if !a! lss 10 (
set  b=00!a!
echo b=!b!    "a<10" 
) else (
set b=0!a!
echo b=!b!     "a<100" 
)
) 
rem 变量a+1
))
rem 这句是注释,执行后没效果
echo 批量改名完成
pause

goto start
      = EQU - 等于
      = NEQ - 不等于
      = LSS - 小于
      = LEQ - 小于或等于
      = GTR - 大于
      = GEQ - 大于或等于
:sta
```
