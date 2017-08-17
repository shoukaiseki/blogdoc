# VIM配色说明  

```Vim
" Vim color file
"
" Author: Tomas Restrepo <tomas@winterdom.com>
"
" Note: Based on the monokai theme for textmate
" by Wimer Hazenberg and its darker variant 
" by Hamish Stuart Macpherson
"

hi clear

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="molokai"

if exists("g:molokai_original")
    let s:molokai_original = g:molokai_original
else
    let s:molokai_original = 0
endif


hi Boolean         guifg=LightBlue  "布尔
hi Character       guifg=LightBlue  "Character
hi Number          guifg=LightBlue
hi String          guifg=LightBlue  "String
hi Conditional     guifg=LightBlue               gui=bold "条件F92672 if
hi Constant        guifg=LightBlue               gui=bold "恒定AE81FF
hi Cursor          guifg=LightBlue guibg=LightBlue
hi Debug           guifg=LightBlue               gui=bold "调试
hi Define          guifg=LightBlue    "定义 int char
hi Delimiter       guifg=LightBlue    "定界符
hi DiffAdd                       guibg=LightBlue  "13354A
hi DiffChange      guifg=LightBlue guibg=LightBlue  "4C4745
hi DiffDelete      guifg=LightBlue guibg=LightBlue  "1E0010
hi DiffText                      guibg=LightBlue gui=italic,bold "4C4745

hi Directory       guifg=LightBlue               gui=bold
hi Error           guifg=LightBlue guibg=LightBlue
hi ErrorMsg        guifg=LightBlue guibg=LightBlue gui=bold
hi Exception       guifg=LightBlue               gui=bold
hi Float           guifg=LightBlue
hi FoldColumn      guifg=LightBlue guibg=LightBlue
hi Folded          guifg=LightBlue guibg=LightBlue
hi Function        guifg=LightBlue
hi Identifier      guifg=LightBlue    "标识符FD971F
hi Ignore          guifg=LightBlue guibg=bg 
hi IncSearch       guifg=LightBlue guibg=LightBlue

hi Keyword         guifg=LightBlue               gui=bold
hi Label           guifg=LightBlue               gui=none
hi Macro           guifg=LightBlue               gui=italic
hi SpecialKey      guifg=LightBlue               gui=italic

hi MatchParen      guifg=LightBlue guibg=LightBlue gui=bold
hi ModeMsg         guifg=LightBlue
hi MoreMsg         guifg=LightBlue
hi Operator        guifg=LightBlue

" complete menu
hi Pmenu           guifg=LightBlue guibg=LightBlue
hi PmenuSel                      guibg=LightBlue
hi PmenuSbar                     guibg=LightBlue
hi PmenuThumb      guifg=LightBlue

hi PreCondit       guifg=LightBlue               gui=bold
hi PreProc         guifg=LightBlue
hi Question        guifg=LightBlue
hi Repeat          guifg=LightBlue               gui=bold
hi Search          guifg=#FFFFFF guibg=#455354 "搜索的背景色
" marks column
hi SignColumn      guifg=LightBlue guibg=LightBlue
hi SpecialChar     guifg=LightBlue               gui=bold
hi SpecialComment  guifg=LightBlue               gui=bold
hi Special         guifg=LightBlue guibg=bg      gui=italic
hi SpecialKey      guifg=LightBlue               gui=italic
if has("spell")
    hi SpellBad    guisp=LightBlue gui=undercurl
    hi SpellCap    guisp=LightBlue gui=undercurl
    hi SpellLocal  guisp=LightBlue gui=undercurl
    hi SpellRare   guisp=LightBlue gui=undercurl
endif
hi Statement       guifg=LightBlue               gui=bold
hi StatusLine      guifg=LightBlue guibg=fg
hi StatusLineNC    guifg=LightBlue guibg=LightBlue  "分界线
hi StorageClass    guifg=LightBlue              gui=italic
hi Structure       guifg=LightBlue
hi Tag             guifg=LightBlue               gui=italic
hi Title           guifg=LightBlue
hi Todo            guifg=LightBlue guibg=bg      gui=bold

hi Typedef         guifg=LightBlue
hi Type            guifg=LightBlue              gui=none
hi Underlined      guifg=LightBlue               gui=underline

hi VertSplit       guifg=LightBlue guibg=LightBlue gui=bold
hi VisualNOS                     guibg=LightBlue
hi Visual                        guibg=LightBlue
hi WarningMsg      guifg=LightBlue guibg=LightBlue gui=bold
hi WildMenu        guifg=LightBlue guibg=LightBlue

if s:molokai_original == 1
   hi Normal          guifg=LightBlue guibg=LightBlue  "a
   hi Comment         guifg=LightBlue
   hi CursorLine                    guibg=LightBlue  "a
   hi CursorColumn                  guibg=LightBlue  "a
   hi LineNr          guifg=LightBlue guibg=LightBlue  'a
   hi NonText         guifg=LightBlue guibg=LightBlue  "a
else
   hi Normal          guifg=LightBlue  guibg=#1B1D1E "普通字体颜色, 背景色
   hi Comment         guifg=LightBlue    "注释#465457
   hi CursorLine                    guibg=LightBlue "行号
   hi CursorColumn                  guibg=LightBlue
   hi LineNr          guifg=LightBlue guibg=#232526 "行号背景色
   hi NonText         guifg=LightBlue guibg=#232526
end

"
" Support for 256-color terminal
"
if &t_Co > 255
   hi Boolean         ctermfg=135
   hi Character       ctermfg=144
   hi Number          ctermfg=135
   hi String          ctermfg=144
   hi Conditional     ctermfg=161               cterm=bold
   hi Constant        ctermfg=135               cterm=bold
   hi Cursor          ctermfg=16  ctermbg=253
   hi Debug           ctermfg=225               cterm=bold
   hi Define          ctermfg=81
   hi Delimiter       ctermfg=241

   hi DiffAdd                     ctermbg=24
   hi DiffChange      ctermfg=181 ctermbg=239
   hi DiffDelete      ctermfg=162 ctermbg=53
   hi DiffText                    ctermbg=102 cterm=bold

   hi Directory       ctermfg=118               cterm=bold
   hi Error           ctermfg=219 ctermbg=89
   hi ErrorMsg        ctermfg=199 ctermbg=16    cterm=bold
   hi Exception       ctermfg=118               cterm=bold
   hi Float           ctermfg=135
   hi FoldColumn      ctermfg=67  ctermbg=16
   hi Folded          ctermfg=67  ctermbg=16
   hi Function        ctermfg=118
   hi Identifier      ctermfg=208
   hi Ignore          ctermfg=244 ctermbg=232
   hi IncSearch       ctermfg=193 ctermbg=16

   hi Keyword         ctermfg=161               cterm=bold
   hi Label           ctermfg=229               cterm=none
   hi Macro           ctermfg=193
   hi SpecialKey      ctermfg=81

   hi MatchParen      ctermfg=16  ctermbg=208 cterm=bold
   hi ModeMsg         ctermfg=229
   hi MoreMsg         ctermfg=229
   hi Operator        ctermfg=161

   " complete menu
   hi Pmenu           ctermfg=81  ctermbg=16
   hi PmenuSel                    ctermbg=244
   hi PmenuSbar                   ctermbg=232
   hi PmenuThumb      ctermfg=81

   hi PreCondit       ctermfg=118               cterm=bold
   hi PreProc         ctermfg=118
   hi Question        ctermfg=81
   hi Repeat          ctermfg=161               cterm=bold
   hi Search          ctermfg=253 ctermbg=66

   " marks column
   hi SignColumn      ctermfg=118 ctermbg=235
   hi SpecialChar     ctermfg=161               cterm=bold
   hi SpecialComment  ctermfg=245               cterm=bold
   hi Special         ctermfg=81  ctermbg=232
   hi SpecialKey      ctermfg=245

   hi Statement       ctermfg=161               cterm=bold
   hi StatusLine      ctermfg=238 ctermbg=253
   hi StatusLineNC    ctermfg=244 ctermbg=232
   hi StorageClass    ctermfg=208
   hi Structure       ctermfg=81
   hi Tag             ctermfg=161
   hi Title           ctermfg=166
   hi Todo            ctermfg=231 ctermbg=232   cterm=bold

   hi Typedef         ctermfg=81
   hi Type            ctermfg=81                cterm=none
   hi Underlined      ctermfg=244               cterm=underline

   hi VertSplit       ctermfg=244 ctermbg=232   cterm=bold
   hi VisualNOS                   ctermbg=238
   hi Visual                      ctermbg=235
   hi WarningMsg      ctermfg=231 ctermbg=238   cterm=bold
   hi WildMenu        ctermfg=81  ctermbg=16

   hi Normal          ctermfg=252 ctermbg=233
   hi Comment         ctermfg=59
   hi CursorLine                  ctermbg=234   cterm=none
   hi CursorColumn                ctermbg=234
   hi LineNr          ctermfg=250 ctermbg=234
   hi NonText         ctermfg=250 ctermbg=234
end
```
