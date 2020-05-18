if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dir https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'kana/vim-operator-user'                                          " 映射
Plug 'vim-scripts/ShowTrailingWhitespace'                              " 高亮多余的空格
Plug 'skywind3000/asyncrun.vim'                                        " 运行命令
Plug 'lilydjwg/fcitx.vim'                                              " 自动切换 fcitx 的输入状态
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}} " lsp
Plug 'ap/vim-buftabline'                                               " 顶端 buffer 列表
Plug 'godlygeek/tabular'                                               " Tabularize /=\zs 按 '=' 对齐, 参数 zs 排除 '='
Plug 'liuchengxu/vim-which-key'                                        " cheatsheet
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }                      " fzf
Plug 'tpope/vim-fugitive'                                              " git

Plug 'jceb/vim-orgmode'
Plug 'joshdick/onedark.vim'
call plug#end()


" 配置
set nocompatible
set relativenumber
set mouse= " 鼠标
set showcmd " 在状态栏显示正在输入的命令
set showmode " 左下角显示当前vim模式
set scrolloff=7 " 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set hidden
set signcolumn=yes
set timeoutlen=500
syntax on

" 缩进和对齐
set autoindent
set smartindent
set cindent
set tabstop =4
set shiftwidth =4
" 显示tab和空格
set list
set lcs=tab:\|\ ,nbsp:%,trail:- " 设置tab和空格样式
highlight LeaderTab guifg=#666666 " 设定行首tab为灰色
match LeaderTab /^\t/
set ts=4 sts=4 sw=4 et

function! HideNumber() " 行号开关
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

" 键位
let g:mapleader      = "\<space>"
let g:maplocalleader = ","
let g:which_key_map =  {}

nmap <silent><esc> :nohlsearch<CR>
map <C-j> <C-W>j " move window
map <C-k> <C-W>k " move window
map <C-h> <C-W>h " move window
map <C-l> <C-W>l " move window

nmap <silent> w= : resize +3<CR>
nmap <silent> w- : resize -3<CR>
nmap <silent> w[ : vertical resize -3<CR>
nmap <silent> w] : vertical resize +3<CR>
nmap <silent> w  : <c-u>WhichKey  'w'<CR>

" <c-i> 提示补全
imap <silent><expr> <c-i> coc#refresh()

command! -nargs=0 Format :call CocAction('format')
vmap <C-f>   <Plug>(coc-format-selected)
nmap <silent> K :call CocActionAsync('doHover')<CR>

nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> g  : <c-u>WhichKey 'g'<CR>

" 顶端buffer列表
" bd 关闭buffer, bw 保存并关闭 buffer
" ls -> 1,3bd
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>
nnoremap <leader>1 :1b<CR>
nnoremap <leader>2 :2b<CR>
nnoremap <leader>3 :3b<CR>
nnoremap <leader>4 :4b<CR>
nnoremap <leader>5 :5b<CR>
nnoremap <leader>6 :6b<CR>
nnoremap <silent> <leader> : <c-u>WhichKey  '<leader>'<CR>

let g:Lf_PreviewInPopup = 1
noremap <leader>f :<C-U><C-R>=printf("Leaderf file %s", "")<CR><CR>
noremap <leader>r :<C-U><C-R>=printf("Leaderf rg %s", "")<CR><CR>
noremap <leader>l :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <leader>m :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>

" cheatsheet
call which_key#register('<leader>', "g:which_key_map")
nnoremap <silent> <localleader> :<c-u>WhichKey  '<localleader>'<CR>

" 兼容性
" for onedark.vim
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
colorscheme onedark

" kconsole 不支持 guicursor
set guicursor=
