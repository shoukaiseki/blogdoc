# VIM添加快速注释插件

下载地址:http://www.vim.org/scripts/script.php?script_id=1528

win平台下下载后的comments.vim放到./vimfiles/plugin目录

更改注释快捷键:

原快捷键为Ctrl+C注释,Ctrl+X取消注释
```Vim
" key-mappings for comment line in normal mode
noremap  <silent> <C-C> :call CommentLine()<CR>
" key-mappings for range comment lines in visual <Shift-V> mode
vnoremap <silent> <C-C> :call RangeCommentLine()<CR>

" key-mappings for un-comment line in normal mode
noremap  <silent> <C-X> :call UnCommentLine()<CR>
" key-mappings for range un-comment lines in visual <Shift-V> mode
vnoremap <silent> <C-X> :call RangeUnCommentLine()<CR>
```
更改后快捷键为:Alt+c注释,Alt+v取消注释.(注意用小写字母)
```Vim
"" key-mappings for comment line in normal mode
"noremap  <silent> <A-c> :call CommentLine()<CR>
"" key-mappings for range comment lines in visual <Shift-V> mode
"vnoremap <silent> <A-c> :call RangeCommentLine()<CR>

"" key-mappings for un-comment line in normal mode
"noremap  <silent> <A-v> :call UnCommentLine()<CR>
"" key-mappings for range un-comment lines in visual <Shift-V> mode
"vnoremap <silent> <A-v> :call RangeUnCommentLine()<CR>
```
