set nocompatible
" 绝对行号
set relativenumber
" 开启语法高亮
syntax on
" 退出后不清空屏幕
set t_ti= t_te=
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
if has('nvim')
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dir https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
else
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dir https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

call plug#begin('~/.config/nvim/plugged')
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-clang'										" c++补全
Plug 'shougo/neoinclude.vim'									" include 补全
Plug 'kana/vim-operator-user'									" 映射
Plug 'rhysd/vim-clang-format'									" 自动格式化
Plug 'vim-scripts/ShowTrailingWhitespace'						" 高亮多余的空格
Plug 'skywind3000/asyncrun.vim'									" 异步运行命令
Plug 'scrooloose/syntastic'										" 语法报错
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'									" markdown 语法
Plug 'fugalh/desert.vim'										" 配色
Plug 'lilydjwg/fcitx.vim'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'mileszs/ack.vim'
call plug#end()

" ctrl-i 自动格式化
map <C-i> <Plug>(operator-clang-format)
set hidden
let g:racer_cmd = "/bin/racer"
let g:racer_experimental_completer = 1


" 启动自动补全
call deoplete#enable()

" syntasitc 的推荐设置
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:rustfmt_autosave = 1

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)


let g:ackprg = 'ag --vimgrep'
colorscheme desert


if has('nvim')
  set guicursor=
endif
