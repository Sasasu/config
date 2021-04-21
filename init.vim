if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dir https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source "~/.config/nvim/init.vim"
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'kana/vim-operator-user'                                        " 映射
Plug 'ntpeters/vim-better-whitespace'                                " 高亮多余的空格
Plug 'lilydjwg/fcitx.vim'                                            " 自动切换 fcitx 的输入状态
Plug 'ap/vim-buftabline'                                             " 顶端 buffer 列表
Plug 'godlygeek/tabular'                                             " Tabularize /=\zs 按 '=' 对齐, 参数 zs 排除 '='
Plug 'liuchengxu/vim-which-key'                                      " cheatsheet
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }                    " fzf
Plug 'tpope/vim-fugitive'                                            " git
Plug 'voldikss/vim-floaterm'                                         " popup terminal
Plug 'mileszs/ack.vim'                                               " !Ark
Plug 'scrooloose/nerdtree'                                           " 文件树
Plug 'jceb/vim-orgmode'                                              " orgmode
Plug 'neoclide/coc.nvim', {'branch': 'release'}                      " lsp
Plug 'jackguo380/vim-lsp-cxx-highlight'                              " 语义高亮
Plug 'maskray/vscode-ccls', {'do': 'yarn install --frozen-lockfile'} " ccls
Plug 'joshdick/onedark.vim'                                          " 主题
Plug 'solarnz/thrift.vim'                                            " 高亮
Plug 'lfv89/vim-interestingwords' " <leader-k> 高亮 <leader-K> 取消
call plug#end()

" 配置
set nocompatible
set relativenumber
set mouse=  " 鼠标
set showcmd " 在状态栏显示正在输入的命令
set showmode " 左下角显示当前vim模式
set scrolloff=7 " 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set hidden
set colorcolumn=100
set nowrap
set signcolumn=yes
set timeoutlen=500
syntax on

" 缩进和对齐
set autoindent smartindent list
set tabstop =4 shiftwidth =4
set noexpandtab
set lcs=tab:\|\ ,nbsp:%,trail:- " 设置tab和空格样式
highlight LeaderTab guifg=#666666
match LeaderTab /^\t/

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
let g:mapleader      = "."
let g:maplocalleader = ","
let g:which_key_map =  {}

nmap <silent><esc> :nohlsearch<CR>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nmap w= :resize +3<CR>
nmap w- :resize -3<CR>
nmap w[ :vertical resize -3<CR>
nmap w] :vertical resize +3<CR>
nmap w  :<c-u>WhichKey  'w'<CR>

" <c-i> 提示补全
imap <silent><expr> <c-i> coc#refresh()

command! -nargs=0 CFormat :call CocActionAsync('format')
command! -nargs=0 CFormatSelected :call CocActionAsync('formatSelected', 'v')
command! -nargs=0 CSign :call CocActionAsync('showSignatureHelp')
command! -nargs=0 CRename :call CocActionAsync('rename')
command! -nargs=0 COutLine CocList outline
command! -nargs=0 CDocSymbols :call CocActionAsync('documentSymbols')
vmap <C-f> :call CocActionAsync('formatSelected', 'v')<CR>
nmap K     :call CocActionAsync('doHover')<CR>
nmap gd    :call CocActionAsync("jumpDefinition")<CR>
nmap gy    :call CocActionAsync("jumpDeclaration")<CR>
nmap gi    :call CocActionAsync("jumpImplementation")<CR>
nmap gr    :call CocActionAsync("jumpReferences")<CR>
nmap ?g    :<c-u>WhichKey 'g'<CR>

nmap <buffer> <A-l> :call CocLocations('ccls','$ccls/navigate',{'direction':'D'})<cr>
nmap <buffer> <A-k> :call CocLocations('ccls','$ccls/navigate',{'direction':'L'})<cr>
nmap <buffer> <A-j> :call CocLocations('ccls','$ccls/navigate',{'direction':'R'})<cr>
nmap <buffer> <A-h> :call CocLocations('ccls','$ccls/navigate',{'direction':'U'})<cr>


" 顶端buffer列表
" bd 关闭buffer, bw 保存并关闭 buffer
" ls -> 1,3bd
nmap <C-N> :bnext<CR>
nmap <C-P> :bprev<CR>
nmap bd    :<c-u>bd<CR>
nmap bw    :<c-u>bw<CR>

let g:Lf_PreviewInPopup = 1
let g:Lf_ShortcutF = "<leader>fx"
nmap <leader>ff :<C-U><C-R>=printf("Leaderf file %s", "")<CR><CR>
nmap <leader>fr :<C-U><C-R>=printf("Leaderf rg %s", "")<CR><CR>
nmap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
nmap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>

" popup terminal
nmap tt :FloatermNew  <CR>
nmap th :FloatermHide  <CR>
nmap ts :FloatermShow  <CR>
nmap tn :FloatermNext  <CR>
nmap tp :FloatermPrev  <CR>
nmap t  :<c-u>WhichKey  't'<CR>
tmap <C-Q> <C-\><C-n>
tmap <Esc> <C-\><C-n>th

" explorer
command! -nargs=0 NTree NERDTree
command! -nargs=0 CTree CocCommand explorer

" cheatsheet
call which_key#register('<leader>', "g:which_key_map")
nmap <leader>      :<c-u>WhichKey  '<leader>'<CR>
nmap <localleader> :<c-u>WhichKey  '<localleader>'<CR>

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

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let g:lsp_cxx_hl_use_text_props = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

iunmap <Tab>
