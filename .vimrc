set nocompatible
set backspace=indent,eol,start "Backspaceを調整
set number       "行番号を表示
"set cursorline   "カーソル行の背景色を変える
set laststatus=2 "カーソル位置のカラムの背景色を変える
set whichwrap=b,s,h,l,<,>,[,] "行頭行末の左右移動で行をまたぐ

set hlsearch     "検索文字列をハイライトする
set wrapscan     "最後尾まで検索を終えたら先頭に移る

set shiftwidth=2  "インデント幅
set tabstop=2     "タブ幅
set cindent       "インデントを自動で入れる
set expandtab     "タブをスペースに変更
set ruler         "カーソル位置情報を表示

syntax on         "シンタックスハイライト

highlight Comment    ctermfg=Blue "コメント色を変更
highlight Directory  ctermfg=Blue
highlight SpecialKey ctermfg=Blue

set tags=./tags;

"日本語文字化け対策
set encoding=utf-8
set fileencoding=utf-8
"set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac


nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>

nnoremap <F3> :<C-u>tab stj <C-R>=expand('<cword>')<CR><CR>
"nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>    Ctrl+hで垂直分割＆タグジャンプ
nnoremap <C-h> :vsplit<CR> :exe("tjump ".expand('<cword>'))<CR>  "Ctrl+kで水平分割＆タグジャンプ

"inoremap ' ''<LEFT>
"inoremap " ""<LEFT>
"inoremap ( ()<LEFT>
"inoremap { {}<LEFT>
"inoremap [ []<LEFT>

" <C-j>をESPに割り当て
imap <c-j> <esc>


""""""""""""""""""""""""""""""""
"     Windows Vim特有設定      "
""""""""""""""""""""""""""""""""
"undoファイルの置き場所を変更
"set undodir=C:\vim74-kaoriya-win64\undo
"backupファイルの置き場所を変更
"set backupdir=C:\vim74-kaoriya-win64\backup


" <C-n>でディレクトリツリー表示
map <C-n> :NERDTreeToggle<CR>

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
  endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " Show tabline always

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]

" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" Jump to left edge tab by t1, jump to second left edge tab by t2

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc Create a new tab in right edge
map <silent> [Tag]x :tabclose<CR>
" tx Close a tab
map <silent> [Tag]n :tabnext<CR>
" tn Next tab
map <silent> [Tag]p :tabprevious<CR>
" tp Previous tab

autocmd QuickFixCmdPost *grep* cwindow

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Add or remove your plugins here:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Shougo/neocomplete.vim')

  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif


" neocomplete.vim setting----------------
" Vim起動時にneocompleteを有効にする
let g:neocomplete#enable_at_startup = 1

" smartcase有効化.
" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplete#enable_smart_case = 1
" 3文字以上の単語に対して補完を有効にする
let g:neocomplete#min_keyword_length = 3
" 区切り文字まで補完する
let g:neocomplete#enable_auto_delimiter = 1
" 1文字目の入力から補完のポップアップを表示
let g:neocomplete#auto_completion_start_length = 1
" バックスペースで補完のポップアップを閉じる
inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

" エンターキーで補完候補の確定.
" スニペットの展開もエンターキーで確定
imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
" タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ
imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" :	"<TAB>" 


"End neocomplete.vim setting----------------

"End dein Scripts-------------------------



"copy and paste and search by <C-f>
nnoremap <C-f> "vyiw/<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR>

