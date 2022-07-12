"
"                    /\ \__
"   ___ ___      __  \ \ ,_\  ____      __
"  /' __` __`\  /'__`\ \ \ \/ /\_ ,`\  /'__`\
"  /\ \/\ \/\ \/\ \L\.\_\ \ \_\/_/  /_/\  __/
"  \ \_\ \_\ \_\ \__/.\_\\ \__\ /\____\ \____\
"   \/_/\/_/\/_/\/__/\/_/ \/__/ \/____/\/____/

"{{{ General settings
set nocompatible
set modeline
set noshowcmd
set nocursorcolumn
set noerrorbells
set cursorline
set history=1000
set wildmenu
set wildignore+=*/.git/*,*~,*/build/*,*.pyc
set hidden
set scrolloff=2
set sidescrolloff=2
set mouse=a
set guicursor=
set ttimeoutlen=0
set dir=~/.vim
set clipboard=unnamedplus
set ignorecase
set smartcase
set hlsearch
set wrapscan
set incsearch
set textwidth=80
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set linebreak
set number
set list
set listchars=tab:›\ ,trail:•,nbsp:␣
set fillchars=fold:·
set backspace=indent,eol,start
set signcolumn=yes
set t_Co=256
set foldenable
set foldmethod=marker
set completeopt=menu,menuone,noselect
set shortmess+=c
set laststatus=3

let g:do_filetype_lua = 1
let g:did_load_filetypes = 0
"}}}
"{{{ Plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'AckslD/nvim-neoclip.lua', { 'branch': 'main' }
Plug 'akinsho/nvim-bufferline.lua', { 'branch': 'main' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'dkarter/bullets.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'ggandor/lightspeed.nvim', { 'branch': 'main' }
Plug 'j-hui/fidget.nvim', { 'branch': 'main' }
Plug 'hrsh7th/cmp-cmdline', { 'branch': 'main' }
Plug 'hrsh7th/cmp-buffer', { 'branch': 'main' }
Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main' }
Plug 'hrsh7th/cmp-nvim-lsp-signature-help', { 'branch': 'main' }
Plug 'hrsh7th/cmp-path', { 'branch': 'main' }
Plug 'hrsh7th/nvim-cmp', { 'branch': 'main' }
Plug 'L3MON4D3/LuaSnip'
Plug 'lewis6991/gitsigns.nvim', { 'branch': 'main' }
Plug 'matze/vim-ini-fold', { 'for': 'ini' }
Plug 'matze/vim-lilypond', { 'for': 'lilypond' }
Plug 'matze/vim-move'
Plug 'matze/vim-tex-fold', { 'for': 'tex' }
Plug 'mickael-menu/zk-nvim', { 'branch': 'main' }
Plug 'mvllow/modes.nvim', { 'branch': 'main' }
Plug 'natecraddock/telescope-zf-native.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'numToStr/Comment.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'petRUShka/vim-opencl', { 'for': 'opencl' }
Plug 'p00f/clangd_extensions.nvim', { 'branch': 'main' }
Plug 'protex/better-digraphs.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'simrat39/rust-tools.nvim'

call plug#end()

"{{{ Comment.nvim
lua <<EOF
require('Comment').setup()
EOF
"}}}
"{{{ nvim-bufferline.lua
lua <<EOF
require('bufferline').setup {
  options = {
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    modified_icon = '·',
  },
  highlights = {
    buffer_selected = {
      gui = "bold",
    }
  },
}
EOF
"}}}
"{{{ editorconfig-vim
let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']
"}}}
"{{{ fidget.nvim
lua <<EOF
require('fidget').setup({
  text = {
    spinner = "dots",
  },
  timer = {
    fidget_decay = 0,
    task_decay = 0,
  },
})
EOF
"}}}
"{{{ kanagawa.nvim
lua <<EOF
local colors = require('kanagawa.colors').setup()

require('kanagawa').setup({
  undercurl = true,
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = {},
  statementStyle = {},
  typeStyle = {},
  variablebuiltinStyle = { italic = true },
  specialReturn = false,
  specialException = false,
  transparent = false,
  colors = {},
  overrides = {
    CursorLine = { bg = colors.bg_light0 },
  },
})
EOF
"}}}
"{{{ lualine.nvim
lua <<EOF
require('lualine').setup {
  options = {
    theme = 'kanagawa',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'filetype'},
    lualine_y = {'diff'},
    lualine_z = {'location'}
  },
}
EOF
"}}}
"{{{ gitsigns.nvim
lua <<EOF
require('gitsigns').setup {
  attach_to_untracked = false,
  keymaps = {
    ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
  }
}
EOF
"}}}
"{{{ modes.nvim
lua <<EOF
require('modes').setup({
  set_cursor = false,
  line_opacity = 0.1,
})
EOF
"}}}
"{{{ nvim-neoclip.lua
lua <<EOF
require('neoclip').setup({})
EOF
"}}}
"{{{ nvim-cmp
lua <<EOF
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
    { name = 'path' },
  }),
  mapping = cmp.mapping.preset.insert({
    ['<C-j>'] = cmp.mapping.confirm({ select = true }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
  }),
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline({
  }),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline({
  }),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
EOF
"}}}
"{{{ nvim-lspconfig + rust-tools
lua <<EOF
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K' , '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
end

nvim_lsp.pyright.setup({ on_attach = on_attach })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

require('rust-tools').setup {
  server = {
    on_attach = on_attach,
  },
  tools = {
    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = "← ",
      other_hints_prefix = "⇒ ",
    },
  },
}

require("clangd_extensions").setup {
  server = {
    on_attach = on_attach,
  },
  extensions = {
    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = "← ",
      other_hints_prefix = "⇒ ",
    }
  }
}
EOF
"}}}
"{{{ nvim-treesitter
lua <<EOF
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
  },
}

-- Coremake treesitter parser
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.coremake = {
  install_info = {
    url = "https://github.com/matze/tree-sitter-coremake",
    files = {"src/parser.c"}
  },
  filetype = "coremake"
}
EOF
"}}}
"{{{ telescope
lua <<EOF
require('telescope').load_extension('neoclip')
require('telescope').load_extension('ui-select')
require('telescope').load_extension('zf-native')
require('telescope').load_extension('zk')
require('telescope').setup {
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--exclude", ".git", "--strip-cwd-prefix" },
    },
  }
}

telescope_custom_files = function()
  local ok = pcall(require('telescope.builtin').git_files, {})

  if not ok then
    require('telescope.builtin').find_files({})
  end
end
EOF
"}}}
"{{{ vim-move
let g:move_map_keys = 0

vmap <A-j> <Plug>MoveBlockDown
vmap <A-k> <Plug>MoveBlockUp
nmap <A-j> <Plug>MoveLineDown
nmap <A-k> <Plug>MoveLineUp
"}}}
"{{{ vim-tex-fold
let g:tex_fold_additional_envs = ['tikzpicture']
"}}}
"{{{ zk
lua <<EOF
require("zk").setup({
  picker = "telescope",
})
EOF
"}}}

silent! colorscheme kanagawa
silent! set background=dark

syntax enable

"}}}
"{{{ Functions
" Adapted from github.com/jkramer/vim-checkbox
fu! ToggleCheckbox()
  let line = getline('.')

  if match(line, '- \[ \]') != -1
    call setline('.', substitute(line, '- \[ \]', '- \[x\]', ''))
  elseif match(line, '- \[x\]') != -1
    call setline('.', substitute(line, '- \[x\]', '- \[ \]', ''))
  elseif match(line, '- ') != -1
    call setline('.', substitute(line, '- ', '- \[ \] ', ''))
  endif
endf
"}}}
"{{{ Keymaps
let mapleader = "\<Space>"

inoremap <C-c> <Esc>
nnoremap <C-p> <cmd>lua telescope_custom_files()<CR>
nnoremap <C-b> <cmd>Telescope buffers<CR>
nnoremap <C-f> <cmd>Telescope grep_string<CR>
nnoremap <C-g> <cmd>Telescope live_grep<CR>

nnoremap <Leader>fm <cmd>:lua vim.lsp.buf.formatting()<CR>
nnoremap gd <cmd>Telescope lsp_definitions<CR>
nnoremap gi <cmd>Telescope lsp_implementations<CR>
nnoremap gr <cmd>Telescope lsp_references<CR>
nnoremap ge <cmd>Telescope diagnostics<CR>

inoremap <C-k><C-k> <cmd>lua require'betterdigraphs'.digraphs("i")<CR>
nnoremap r<C-k><C-k> <cmd>lua require'betterdigraphs'.digraphs("r")<CR>
vnoremap r<C-k><C-k> <Esc><Cmd>lua require'betterdigraphs'.digraphs("gvr")<CR>

nnoremap <C-n> <cmd>:ZkNotes<CR>
nnoremap <C-t> <cmd>:ZkTags<CR>
vnoremap <Leader>zn :'<,'>ZkNewFromTitleSelection<CR>
nnoremap <Leader>zb <cmd>:ZkBacklinks<CR>
nnoremap <Leader>zl <cmd>:ZkLinks<CR>
nnoremap <Leader>zc <cmd>:ZkNew<CR>

imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<CR>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<CR>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<CR>

" paste multiple lines without overwriting content
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" select pasted text
noremap gV `[v`]

nnoremap <Right> :bn<CR>
nnoremap <Left> :bp<CR>

nnoremap cn <Esc>:cn<CR>
nnoremap cp <Esc>:cp<CR>

nnoremap <Leader>d :bd<CR>
nnoremap <Leader>w :w!<CR>

nmap <Leader>r1 yypVr=
nmap <Leader>r2 yypVr-
nmap <Leader>fw :%s/\s\+$//<CR>

nmap <Leader>se :setlocal spell spelllang=en<CR>
nmap <Leader>sd :setlocal spell spelllang=de<CR>
nmap <Leader>sn :setlocal nospell<CR>
nmap <Leader>ss 1z=

vmap <Leader>y "+y
vmap <Leader>d "+d
vmap <Leader>p "+p
vmap <Leader>P "+P
nmap <Leader>p "+p
nmap <Leader>P "+P

" Splits
nmap <C-J> <C-W>w
nmap <C-K> <C-W>W
nmap <C-X> :q<CR>
"}}}
"{{{ Autocmds
" Allow using <CR> on quickfix entries
autocmd FileType markdown nnoremap <Leader>cm :call ToggleCheckbox()<CR>
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
autocmd BufWritePre *.rs,*.cpp,*.h lua vim.lsp.buf.formatting_sync()
" }}}
