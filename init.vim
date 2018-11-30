set nocompatible
set relativenumber
syntax on
" 启用鼠标
set mouse=a
" 在状态栏显示正在输入的命令
set showcmd
" 左下角显示当前vim模式
set showmode
" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=7
" 关闭 F1 帮助
noremap <F1> <Esc>
" F2 行号开关，用于鼠标复制代码用
function! HideNumber()
  if(&relativenumber == &number)
    set relativenumber! number!
  elseif(&number)
    set number!
  else
    set relativenumber!
  endif
  set number?
endfunc
nnoremap <F2> :call HideNumber()<CR>
" 窗口移动
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
nmap w= :resize +3<CR>
nmap w- :resize -3<CR>
nmap w[ :vertical resize -3<CR>
nmap w] :vertical resize +3<CR>
" 缩进和对齐
set autoindent
set smartindent
set cindent
set tabstop =4
set shiftwidth =4
" 显示tab和空格
set list
" 设置tab和空格样式
set lcs=tab:\|\ ,nbsp:%,trail:-
" 设定行首tab为灰色
highlight LeaderTab guifg=#666666
" 匹配行首tab
match LeaderTab /^\t/
set ts=4 sts=4 sw=4 et

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dir https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
" Plug 'w0rp/ale' " lsp
Plug 'rust-lang/rust.vim'
Plug 'kana/vim-operator-user'									" 映射
Plug 'vim-scripts/ShowTrailingWhitespace'						" 高亮多余的空格
Plug 'skywind3000/asyncrun.vim'									" 异步运行命令
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'									" markdown 语法
Plug 'fugalh/desert.vim'										" 配色
Plug 'lilydjwg/fcitx.vim'
Plug 'mileszs/ack.vim'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-racer'
Plug 'ncm2/ncm2-jedi'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'jceb/vim-orgmode'
call plug#end()

set hidden
" neovim-lsp
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rls']
    \ }
" ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let b:ale_linters = {'rust': ['rls']}

let g:ackprg = 'ag --vimgrep'

colorscheme desert
set termguicolors
set background=dark
highlight Normal guibg=NONE ctermbg=None

if has('nvim')
  set guicursor=
endif

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
