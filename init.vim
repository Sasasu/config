set nocompatible
set relativenumber
syntax on
" 鼠标
set mouse=
" 在状态栏显示正在输入的命令
set showcmd
" 左下角显示当前vim模式
set showmode
" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=7
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
nnoremap <F1> :call HideNumber()<CR>
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
match LeaderTab /^\t/

set ts=4 sts=4 sw=4 et

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dir https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
" 映射
Plug 'kana/vim-operator-user'
" 高亮多余的空格
Plug 'vim-scripts/ShowTrailingWhitespace'
" 异步运行命令
Plug 'skywind3000/asyncrun.vim'
" 配色
Plug 'fugalh/desert.vim'
" Linux 下自动切换 fcitx 的输入状态
Plug 'lilydjwg/fcitx.vim'
" !Ack 全文搜索
Plug 'mileszs/ack.vim'
" orgmode 记笔记
Plug 'jceb/vim-orgmode'
" lsp
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
" Tabularize /=\zs 按 "=" 对齐, 参数 zs 排除 "="
Plug 'godlygeek/tabular'

" 一堆补全插件
" Plug 'ncm2/ncm2'
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-tmux'
" Plug 'ncm2/ncm2-path'
" Plug 'ncm2/ncm2-racer'
" Plug 'ncm2/ncm2-jedi'

call plug#end()

" ======= 插件配置 ==========
let g:ackprg = 'ag --vimgrep'

colorscheme desert
set termguicolors
set background=dark
highlight Normal guibg=NONE ctermbg=None

if has('nvim')
" kconsole 不支持 guicursor
  set guicursor=
endif

nmap <c-f>   <Plug>(coc-format-selected)
nmap <silent><esc> :noh<CR>

" <c-space> 提示补全
imap <silent><expr> <c-space> coc#refresh()

vmap <c-f>   <Plug>(coc-format-selected)

