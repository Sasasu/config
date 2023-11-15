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
" Plug 'neoclide/coc.nvim', {'branch': 'release'}                      " lsp
Plug 'jackguo380/vim-lsp-cxx-highlight'                              " 语义高亮
Plug 'maskray/vscode-ccls', {'do': 'yarn install --frozen-lockfile'} " ccls
Plug 'joshdick/onedark.vim'                                          " 主题
Plug 'solarnz/thrift.vim'                                            " 高亮
Plug 'lfv89/vim-interestingwords' " <leader-k> 高亮 <leader-K> 取消
Plug 'frazrepo/vim-rainbow'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'neovim/nvim-lspconfig'

Plug 'github/copilot.vim'

call plug#end()

" 配置
set nocompatible
set relativenumber
set number
set mouse=  " 鼠标
set showcmd " 在状态栏显示正在输入的命令
set showmode " 左下角显示当前vim模式
set scrolloff=7 " 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set hidden
set colorcolumn=80
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

function! SwithCopilot()
  let g:copilot_enabled = ! g:copilot_enabled
endfunc
nnoremap <F2> :call SwithCopilot()<CR>
let g:copilot_enabled = 0

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
" imap <silent><expr> <c-i> coc#refresh()
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
"
" command! -nargs=0 CFormat :call CocActionAsync('format')
" command! -nargs=0 CFormatSelected :call CocActionAsync('formatSelected', 'v')
" command! -nargs=0 CSign :call CocActionAsync('showSignatureHelp')
" command! -nargs=0 CRename :call CocActionAsync('rename')
" command! -nargs=0 COutLine CocList outline
" command! -nargs=0 CDocSymbols :call CocActionAsync('documentSymbols')
" nmap K     :call CocActionAsync('doHover')<CR>
" nmap gd    :call CocActionAsync("jumpDefinition")<CR>
" nmap gy    :call CocActionAsync("jumpDeclaration")<CR>
" nmap gi    :call CocActionAsync("jumpImplementation")<CR>
" nmap gr    :call CocActionAsync("jumpReferences")<CR>
" nmap ?g    :<c-u>WhichKey 'g'<CR>
" nmap <leader>a  <Plug>(coc-codeaction)
" nmap <leader>al <Plug>(coc-codelens-action)
" nmap <leader>af <Plug>(coc-fix-current)
"
" nmap <buffer> <A-l> :call CocLocations('ccls','$ccls/navigate',{'direction':'D'})<cr>
" nmap <buffer> <A-k> :call CocLocations('ccls','$ccls/navigate',{'direction':'L'})<cr>
" nmap <buffer> <A-j> :call CocLocations('ccls','$ccls/navigate',{'direction':'R'})<cr>
" nmap <buffer> <A-h> :call CocLocations('ccls','$ccls/navigate',{'direction':'U'})<cr>


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
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

let g:lsp_cxx_hl_use_text_props = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:neovide_cursor_vfx_mode = "pixiedust"
let g:rainbow_active = 1

lua << EOF
local lspconfig = require('lspconfig')
local cmp = require'cmp'

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)


cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})


local on_attach = function(client, bufnr)
  if vim.g.config.use_winbar == true then
    navic.attach(client, bufnr)
  end
  if client.name == 'gopls' then
    client.server_capabilities.semanticTokensProvider = {
      full = true,
      legend = {
        tokenTypes = { 'namespace', 'type', 'class', 'enum', 'interface', 'struct', 'typeParameter', 'parameter', 'variable', 'property', 'enumMember', 'event', 'function', 'method', 'macro', 'keyword', 'modifier', 'comment', 'string', 'number', 'regexp', 'operator', 'decorator' },
        tokenModifiers = { 'declaration', 'definition', 'readonly', 'static', 'deprecated', 'abstract', 'async', 'modification', 'documentation', 'defaultLibrary'}
      }
    }
  end
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      semanticTokens = true,
      staticcheck = true,
      gofumpt = true,
    },
  },
}

lspconfig.clangd.setup {}
lspconfig.pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391'},
          maxLineLength = 100
        }
      }
    }
  }
}

EOF
