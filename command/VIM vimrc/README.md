# VIM vimrc

```Vim
set backspace=indent,eol,start
""""""""""""""""""""""
""设置字体
""""""""""""""""""""""
"set guifont=文泉驿正黑\ 16
"set guifont=Monaco\ 12
set guifont=Courier\ New\ 12
set fenc="zh_CN.UTF-8""设定默认解码 
set fencs=zh_CN.UTF-8,utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936
set cursorline              " 突出显示当前行
set nocp "或者 set nocompatible 用于关闭VI的兼容模式 
set number "显示行号 
set ai "或者 set autoindent vim使用自动对齐，也就是把当前行的对齐格式应用到下一行 
set si "或者 set smartindent 依据上面的对齐格式，智能的选择对齐方式
set tabstop=4 "设置tab键为4个空格
set sw=4 "或者 set shiftwidth 设置当行之间交错时使用4个空格
set ruler "设置在编辑过程中,于右下角显示光标位置的状态行 
set incsearch "设置增量搜索,这样的查询比较smart " 输入搜索内容时就显示搜索结果
set hlsearch                " 搜索时高亮显示被找到的文本
set showmatch "高亮显示匹配的括号 
set matchtime=5 "匹配括号高亮时间(单位为 1/10 s) 
set ignorecase "在搜索的时候忽略大小写 
syntax on "高亮语法
syntax enable      " 设定配色方案
colorscheme molokai   "desert
let Tlist_Show_One_File=1    "教你高效地浏览源码 -- 插件: TagList
let Tlist_Exit_OnlyWindow=1    "教你高效地浏览源码 -- 插件: TagList

"set guifont=Sans:h14:Bold

"""""""""""""""""""""""""""""""
 
"" winManager setting
 
"""""""""""""""""""""""""""""""
 
"设置界面分割
 
"let g:winManagerWindowLayout = "BufExplorer,FileExplorer|TagList"
 
let g:winManagerWindowLayout = "TagList|FileExplorer,BufExplorer"
 
"设置winmanager的宽度，默认为25
 
let g:winManagerWidth = 30
nmap <silent> <F8> :WMToggle<cr> "定义打开关闭winmanager按键
let g:winManagerWindowLayout='FileExplorer|TagList' "文件浏览器和窗口管理器 -- 插件: WinManager
let g:AutoOpenWinManager = 1      "自动打开文件浏览器0关1开
set autochdir               " 自动切换当前目录为当前文件所在的目录
"""""""""""""""""""""""""""""
""
""""""""""""""""""""""""""""
"set guioptions-=T           " 隐藏工具栏
"set guioptions-=m           " 隐藏菜单栏
set smartindent             " 开启新行时使用智能自动缩进
set cmdheight=1             " 设定命令行的行数为 1
set laststatus=2            " 显示状态栏 (默认值为 1, 无法显示状态栏)

set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\ 
                            " 设置在状态行显示的信息
set foldenable              " 开始折叠
set foldmethod=syntax       " 设置语法折叠 " 用语法高亮来定义折叠
"set foldmethod=indent " 更多的缩进表示更高级别的折叠(这个似乎效果好一些)
set foldcolumn=0            " 设置折叠区域的宽度
setlocal foldlevel=1        " 设置折叠层数为
"set foldclose=all           " 设置为自动关闭折叠   
"nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
                            " 用空格键来开关折叠
""""""""""""""""""""""""""""""
""
""""""""""""""""""""""""""""""
set cscopequickfix=s-,c-,d-,i-,t-,e-
```
