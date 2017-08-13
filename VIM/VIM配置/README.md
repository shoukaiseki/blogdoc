# VIM配置  

## 2012-02-09 16:16:36
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
set foldmethod=syntax       " 设置语法折叠
set foldcolumn=0            " 设置折叠区域的宽度
setlocal foldlevel=1        " 设置折叠层数为
"set foldclose=all           " 设置为自动关闭折叠   
"nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
                            " 用空格键来开关折叠
""""""""""""""""""""""""""""""
""
""""""""""""""""""""""""""""""
set cscopequickfix=s-,c-,d-,i-,t-,e-




""""""""""""""""""""""""""""""
""手动添加注释快捷键
""""""""""""""""""""""""""""""
"按Shift+V后按hjkl选择要注释的行(也可按Shift+↑↓←→选择),再按Shift+Ctrl+P进行注释,注释格式为:/**<回车>内容<回车>**/
"wmap<C-S-P>    Ctrl+Shift+P
"dO**/<Esc>PO/**<Esc> 便是依次按下以下按键
vmap <C-S-P>    dO**/<Esc>PO/**<Esc>


/**************************
**vim编码识别插件 fencview   http://www.vim.org/scripts/script.php?script_id=1708
**开启后会自动以html的编码设置来设置编码,而不是靠文件编码
** let g:fencview_html_filetypes='html' 改成'htmlabc'就不在支持html设置的编码格式
**    let g:fencview_auto_patterns='*.txt,*.htm{l\=}' 改成abchtm{l\=}
***************************/
"vim 解决打开文件乱码
"推荐水木社区的 mbbill 开发的 fencview 插件。
"该插件使用词频统计的方式识别编码，正确率非常高。

"这里下载：http://www.vim.org/scripts/script.php?script_id=1708
"下载完后把它移动到vim插件目录，vim7.2默认Linux应该是/usr/share/vim/vim72/plugin/            win下为Vim/vimfiles/plugin
"启用插件的时候，在vim命令模式下输入以下命令

":FencAutoDetect   "自动检测文件编码 （推荐）
":FencView    "在编码列表中选择文件的编码
":FencManualEncoding coding  "手动设置文件编码，用你想使用的编码代替coding
```
## 2017-8-13 20:54:00
```Vim
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim

set guifont=Monospaced:14
"set guifont=Ubuntu_Mono:14

"始终显示命令条
set number
set guioptions=egmrLtT  "默认
set guioptions=egrLt  "默认
"set guioptions-=m	"菜单
"set guioptions-=T	"工具栏
"set guioptions-=l	"左滚动条
"set guioptions+=r	"右滚动条
"set encoding=utf-8
set fileencoding=utf-8
"设定默认解码 
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fenc="zh_CN.UTF-8"  "设定默认解码 
set fileencodings=zh_CN.UTF-8,utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936

behave mswin
colorscheme molokai "desert 
set diffexpr=MyDiff()
function! MyDiff()
  let opts = '-p --remote-tab-silent '
  let opt = '-a --binary  '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"**************************
"按Shift+V后按hjkl选择要注释的行(也可按Shift+↑↓←→选择),再按Shift+Ctrl+P进行注释,注释格式为:/**<回车>内容<回车>**/
"wmap<C-S-P>    Ctrl+Shift+P
"dO**/<Esc>PO/**<Esc>	便是依次按下以下按键
"**************************
vmap <C-S-P>    dO**/<Esc>PO/**<Esc>


"**************************
"**保存工程插件sessionman  http://linux.chinaunix.net/techdoc/desktop/2008/09/19/1033230.shtml	
"***************************
set sessionoptions-=curdir 



"**************************
"**标签页命令	http://shoukaiseki.blog.163.com/blog/static/19285614920121158142939/
"***************************
set showtabline=2    "设置标签栏的显示，0永远不显示 1两个以上显示 2 永远显示
"显示在标签页栏中去除当前所编辑文件的路径信息，只保留文件名
function! GuiTabLabel()
	  let label = ''
	  let bufnrlist = tabpagebuflist(v:lnum)

	  " Add '+' if one of the buffers in the tab page is modified
	  for bufnr in bufnrlist
	    if getbufvar(bufnr, "&modified")
	      let label = '+'
	      break
	    endif
	  endfor



	  " Append the buffer name

    let filename = fnamemodify (bufname (bufnrlist[tabpagewinnr (v:lnum) -1]), ':t')
	 if filename == ''
         let filename .= '未命名'
     endif
	 let label .=filename 

	  "显示标签页数
	  
	  "let label .= '[' . tabpagenr('$') .']'

	  " Append the number of windows in the tab page if more than one

	  let wincount = tabpagewinnr(v:lnum, '$')
	  if wincount > 1
	    let label .= ' '. wincount
	  endif
	  if label != ''
	    let label .= ' '
	  endif

	  return label
	endfunction
	
	"set tabpagemax=10		"默认最多只能打开 10 个标签页,这里设置
	"set guitablabel=%N\ %f	"标签页编号
	set guitablabel=%N:%{GuiTabLabel()}

 "让gvim支持Alt+n来切换标签页

function! Tabmap_Initialize()
    for i in range(1, 9)
        exe "map <A-".i."> ".i."gt"
    endfor
    exe "map <A-0> 10gt"
endfunction
autocmd VimEnter * call Tabmap_Initialize()

"
" alt+左右键来移动标签
"
nn <silent> <M-left> :if tabpagenr() == 1\|exe "tabm ".tabpagenr("$")\|el\|exe "tabm ".(tabpagenr()-2)\|en<CR>
nn <silent> <M-right> :if tabpagenr() == tabpagenr("$")\|tabm 0\|el\|exe "tabm ".tabpagenr()\|en<CR>


"**************************
"**ZenCoding 超快地写网页代码 
"***************************
let g:user_zen_expandabbr_key = '<c-e>'  "Ctrl+E 默认为Ctrl+Y
"let g:use_zen_complete_tag = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"高亮设置 mark setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"nmap、vmap、omap （普通、可视和选择、操作符等待） 
	":nnorempa和:nmap的关系和:noremap和:map的关系一样，只是:nmap的非递归版 
	":nunmap和:nmap的关系和:unmap和:map的关系一样，取消:nmap的绑定。 
	":nmapclear是对应取消所有:map绑定的，慎用！ 

	":nmap是:map的普通模式板，也就是说其绑定的键只作用于普通模式。 
	nmap <silent> ,hl <Plug>MarkSet

	vmap <silent> ,hl <Plug>MarkSet
	"删除一个标记
	nmap <silent> ,hh <Plug>MarkClear
	vmap <silent> ,hh <Plug>MarkClear
	"标记正则表达式
	nmap <silent> ,hr <Plug>MarkRegex	
	vmap <silent> ,hr <Plug>MarkRegex
	"输入\M切换开启状态
	nmap <Leader>M <Plug>MarkToggle
	"输入\N清楚所有Mark
    nmap <Leader>N <Plug>MarkAllClear 
	"输入\r标记正则表达式
	nmap <Leader>r <Plug>MarkRegex
	"开启自动保存Marks
	set viminfo+=!
    "let g:mwHistAdd = '/@' 
	let g:mwAutoLoadMarks = 1 
	let g:mwAutoSaveMarks = 1 
	let g:mwDefaultHighlightingPalette = 'extended'
	let g:mwDefaultHighlightingPalette = 'original'
	colorscheme molokai
	set background=dark
	source $VIM/vimfiles/plugin/mark.vim
	




"配置"
"NERD Tree"

let NERDChristmasTree=1				"让Tree把自己给装饰得多姿多彩漂亮点
let NERDTreeAutoCenter=1			"控制当光标移动超过一定距离时，是否自动将焦点调整到屏中心
"指定书签文件
let NERDTreeBookmarksFile=$VIM.'/konnfigu/NerdBookmarks.txt'
let NERDTreeMouseMode=2				"指定鼠标模式（1.双击打开；2.单目录双文件；3.单击打开）
let NERDTreeShowBookmarks=1			"是否默认显示书签列表
let NERDTreeShowFiles=1				"是否默认显示文件	
let NERDTreeShowHidden=1			"是否默认显示隐藏文件,只对Linux有效
let NERDTreeShowLineNumbers=1		"是否默认显示行号
let NERDTreeWinPos='left'			"窗口位置（’left’ or ‘right’）
let NERDTreeWinSize=31				"窗口宽
"let NERDTreeQuitOnOpen=1			"打开文件后是否关闭NerdTree窗口
"显示文件浏览框按f键选择
"nnoremap f :NERDTreeToggle

let g:winManagerWindowLayout='FileExplorer|TagList'
source $VIM/vimfiles/plugin/NERD_tree.vim
let g:NERDTree_title = "[NERDTree]" 
function! NERDTree_Start() 
	"exe  '1wincmd w'
	"NERDTreeToggle E:\shuto\ノーツ
    exe 'NERDTreeToggle E:\shuto\ノーツ'
endfunction 
function! NERDTree_IsValid() 
return 1 
endfunction
let g:Voom_title = "[Voom]" 
function! Voom_Start() 
	"exe  tabpagewinnr(v:lnum, '$') . 'wincmd w'
	"exe  '4wincmd w'
    exe 'Voom'
endfunction 
function! Voom_IsValid() 
return 1 
endfunction
"Voom自动增加---&---{{{1
"nmap <C-S-P>    ^i---<Esc>$a---{{{1<Esc>
"nmap <A-S-p>    ^i---<Esc>$a---{{{1<Esc>
nmap <Leader>1 ^i---<Esc>$a---{{{1<Esc>o
nmap <Leader>2 ^i---<Esc>$a---{{{2<Esc>o
nmap <Leader>3 ^i---<Esc>$a---{{{3<Esc>o
nmap <Leader>4 ^i---<Esc>$a---{{{4<Esc>o
nmap <Leader>5 ^i---<Esc>$a---{{{5<Esc>o

"let g:winManagerWindowLayout='NERDTree|Voom,FileExplorer|BufExplorer'
""let g:winManagerWindowLayout='NERDTree|FileExplorer,TagList'
"let g:winManagerWindowLayout='NERDTree'
"let g:winManagerWindowLayout='Voom|NERDTree,FileExplorer'
"let g:winManagerWindowLayout='NERDTree|Voom,FileExplorer'
let g:winManagerWindowLayout='NERDTree|Voom,FileExplorer'
"let g:winManagerWindowLayout=g:NERDTreeBufName.',FileExplorer'
"let g:winManagerWindowLayout='FileExplorer|TagList'
let g:winManagerWindowLayout='NERDTree|TagList,FileExplorer'
"let g:winManagerWindowLayout=g:NERDTreeBufName.',FileExplorer'
"let g:winManagerWindowLayout='Voom'
nmap wm :WMToggle<cr>
"NERDTree X:\VimTmp
"NERDTreeToggle
"WMToggle
"NERDTreeToggle
"command Tick call {OpunnNERDTree()}
"function OpunnNERDTreeAuto()
	"let pagenum=tabpagewinnr(v:lnum)
	"%		本窗口文件名称
"endfunction
"autocmd VimEnter * call OpunnNERDTreeAuto()


"taglist-plus调用的ctags58目录
"环境变量上加上ctags58路径
let Tlist_Ctags_Cmd="D:/usr/Vim/ctags58"

"命令补全
set wildmenu   " 显示补全列表
"set wildmode=longest:full   " 补全行为设置,开启后Tab不会切换下一个

"自定義情報(じょうほう)[信息]
iab qpath <c-r>=expand("%:p")<cr>
iab xpath <c-r>=expand("%:p:h")<cr>
iab xfile <c-r>=expand("%")<cr>
iab xdate <c-r>=strftime("20%y年%m月%d日 %H:%M:%S")<cr>
iab ename shou-kaiseki
iab cname 蒋カイセキ


"文件默认保存(ほぞん)[保存]路径
"cd X:\VimTmp
set autochdir

set path+=D:/usr/Vim/ctags58
"关闭java自动补全
"setlocal omnifunc=javacomplete#Complete
"autocmd Filetype java set omnifunc=javacomplete#Complete
"autocmd Filetype java set completefunc=javacomplete#CompleteParamsInf
inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P>
autocmd Filetype java,javascript,jsp inoremap <buffer>  .  .<C-X><C-O><C-P>
filetype indent on		"xml格式化


"echon " vimrc_001"

"let $VIM_CONFIG="G:/log/fedora/org/all-system/vim/config"
let $VIM_CONFIG=$VIM."/org/all-system/vim/config/"
autocmd FileType * source $VIM_CONFIG/../_vimrccolor
autocmd Filetype html source $VIM_CONFIG/html.vim
autocmd Filetype c source $VIM_CONFIG/c.vim
autocmd Filetype xml source $VIM_CONFIG/xml.vim
autocmd Filetype java source $VIM_CONFIG/java.vim
autocmd Filetype jsp source $VIM_CONFIG/jsp.vim
autocmd Filetype py source $VIM_CONFIG/py.vim
autocmd Filetype sh source $VIM_CONFIG/sh.vim
autocmd Filetype vim source $VIM_CONFIG/vim.vim

source $VIM/org/all-system/vim/俺のプラグイン/birt.vim
source $VIM/org/all-system/vim/俺のプラグイン/tabnewLineKonntenntu.vim

"编辑时候当行字数到达一定数字时自动加换行符
"与set nowrap 无关,set nowrap为显示时候是否折行
"vimrc_example.vim 注释掉该文件里 textwidth 行
set textwidth=700

augroup json_autocmd 
  autocmd! 
  autocmd FileType json set autoindent 
  autocmd FileType json set formatoptions=tcq2l 
  autocmd FileType json set textwidth=78 shiftwidth=2 
  autocmd FileType json set softtabstop=2 tabstop=8 
  autocmd FileType json set expandtab 
  autocmd FileType json set foldmethod=syntax 
augroup END

" 多个wiki项目
let g:vimwiki_list = [{'path': 'Z:/samples/vimwiki/src',
    \ 'path_html': 'Z:/samples/vimwiki/html',
    \ 'template_path': 'Z:/samples/vimwiki/template',
    \ 'template_default': 'template',
    \ 'html_header': 'header.htm',
    \ 'html_footer': 'footer.htm',
    \ 'css_name': 'asus.css',
    \ 'template_ext': '.htm'}
    \,{'path': '~/workspace/study/vimwiki/',
    \ 'path_html': '~/workspace/study/vimwiki/html/',
    \ 'template_path': '~/workspace/study/vimwiki/template/',
    \ 'template_default': 'template',
    \ 'html_header': 'header.htm',
    \ 'html_footer': 'footer.htm',
    \ 'auto_export': 1,
    \ 'diary_link_count': 5,
    \ 'template_ext': '.htm'}
    \]
 
" 是否在词条文件保存时就输出html这个会让保存大词条比较慢所以默认没有启用
" 有需要的话就把这一行复制到对应项目里去
"     \ 'auto_export': 1,
 
" 对中文用户来说，我们并不怎么需要驼峰英文成为维基词条
let g:vimwiki_camel_case = 0
  
" 标记为完成的checklist项目会有特别的颜色
let g:vimwiki_hl_cb_checked = 1
  
" 我的vim是没有菜单的，加一个vimwiki菜单项也没有意义
let g:vimwiki_menu = ''
  
" 是否开启按语法折叠会让文件比较慢
"let g:vimwiki_folding = 1
  
" 是否在计算字串长度时用特别考虑中文字符
" let g:vimwiki_CJK_length = 1
  
"设置列表不自动添加 checkbox 框
let g:vimwiki_auto_checkbox = 0
" 指定可以用的html标签
let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1'
 
" 不列出来的，会作聪明地在你的链接后面再加上 .html
let g:vimwiki_file_exts = 'c, cpp, wav, txt, h, hpp, zip, sh, awk, ps, pdf'
 
" 如果生成HTML的目录下有手工hack的html文件，也会被无情的删除，
" 选项配置用户html文件，不被自动删除。
let g:vimwiki_user_htmls = 'contact.html, canvas-1.html, html.html'
 
map <F5> :Vimwiki2HTML<cr> 
map <S-F5> :VimwikiAll2HTML<cr>

filetype indent on
filetype plugin on
filetype plugin indent on

"查找字符时忽略大小写
set ignorecase


command! JsonFormat :execute '%!python -m json.tool'
  \ | :execute '%!python -c "import re,sys;chr=__builtins__.__dict__.get(\"unichr\", chr);sys.stdout.write(re.sub(r\"\\u[0-9a-f]{4}\", lambda x: chr(int(\"0x\" + x.group(0)[2:], 16)).encode(\"utf-8\"), sys.stdin.read()))"'
  \ | :set ft=javascript
  \ | :1

source $VIM_CONFIG/../_vimrccolor
"set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
"set encoding=utf-8
"set termencoding=cp936
"language messages zh_CN.UTF-8
"
" 需要在 ~ 目录下新建一个 .undodir 目录
set undodir=~/.undodir
"快捷键F2
source D:\usr\Vim\org\all-system\vim\flute\flute.vim
```
