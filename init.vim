set nocompatible
" 绝对行号
set relativenumber
" 开启语法高亮
syntax on
" 退出后不清空屏幕
set t_ti= t_te=
" 禁用鼠标
set mouse-=a
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
" 缩进和对齐
set autoindent
set smartindent
set cindent
set tabstop =4
set shiftwidth =4
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dir https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } 	" 补全框架
Plug 'zchee/deoplete-clang'										" c++补全
Plug 'shougo/neoinclude.vim'									" include 补全
Plug 'kana/vim-operator-user'									" 映射
Plug 'rhysd/vim-clang-format'									" 自动格式化
Plug 'vim-scripts/ShowTrailingWhitespace'						" 高亮多余的空格
Plug 'skywind3000/asyncrun.vim'									" 异步运行命令
Plug 'scrooloose/syntastic'										" 语法报错
call plug#end()

" ctrl-i 自动格式化
map <C-i> <Plug>(operator-clang-format)

" 启动自动补全
call deoplete#enable()


" syntasitc 的推荐设置
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
