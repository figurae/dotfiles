set autochdir		    " automatically switch to current file dir
set showmatch		    " highlight matching braces
set mouse=a		    " enable mouse support everywhere
set hlsearch		    " highlight all matches
set incsearch		    " highlight matches while typing
set tabstop=8		    " tab width
set softtabstop=4	    " soft tab width
set shiftwidth=4	    " auto indent width
set autoindent		    " enable auto indentation
set number relativenumber   " enable line numbering
set wildmode=longest,list   " enable autocompletion
" set cc=75		    " border at column 75
" TODO: why does this also wrap status bar?
" set columns=80	    " soft wrap at 80
set wrap linebreak	    " soft wrap at linebreak
filetype plugin on	    " file-dependent plugin loading
filetype plugin indent on   " file-dependent auto indentation
syntax on		    " enable syntax highlighting
" TODO: check it
" set clipboard=unnamedplus " do I want this?
set cursorline		    " highlight current line
" TODO: check it
set ttyfast		    " does this even do anything anymore?
" TODO: maybe per file type?
" set spell		    " enable spell checking
set termguicolors	    " moar colours *^__^*
set nohlsearch		    " don't highlight searches

" pluginz go brr

" if empty(glob('~/.config/nvim/autoload/plug.vim'))
" 	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" 	autocmd VimEnter * PlugInstall
" endif

call plug#begin('~/.config/nvim/plugged')
Plug 'rust-lang/rust.vim'
Plug 'dracula/vim'
Plug 'arcticicestudio/nord-vim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'sainnhe/gruvbox-material'
Plug 'luisiacc/gruvbox-baby', { 'branch': 'main' }
" Plug 'xiyaowong/nvim-transparent'	" let me see my desktop, senpai!
Plug 'neovim/nvim-lspconfig'		" common configs
Plug 'neovim/nvim-lsp'
" code completion; maybe nvim-cmp? ddc.vim?
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'deoplete-plugins/deoplete-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
" snippets engine
Plug 'hrsh7th/vim-vsnip' 
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'simrat39/rust-tools.nvim'		" more rust-analyzer features
" Plug 'Chiel92/vim-autoformat'		" autoformatter
Plug 'nvim-lua/popup.nvim'		" popup API
Plug 'nvim-lua/plenary.nvim'		" various modules
" fuzzy finder
Plug 'nvim-telescope/telescope.nvim'
Plug 'BurntSushi/ripgrep'
" TODO: make this work with code actions
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'Pocco81/AutoSave.nvim'
Plug 'psliwka/vim-smoothie'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
" Plug 'akinsho/toggleterm.nvim'
Plug 'numToStr/FTerm.nvim'
Plug 'beauwilliams/statusline.lua'
Plug 'kosayoda/nvim-lightbulb/'
Plug 'drzel/vim-gui-zoom'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-endwise'
Plug 'rstacruz/vim-closer'
Plug 'p00f/nvim-ts-rainbow'
" Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-repeat'
Plug 'figurae/vim-z80-democoding'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
call plug#end()

" colorscheme dracula		    " DRAKULAAA @vv@
" colorscheme nord
" colorscheme tokyonight
colorscheme gruvbox-baby
" let g:transparent_enabled = v:true" always enable TransparentEnable ;p

" dis does not work. y is dis here?
" lua require'nvim_lsp'.rust_analyzer.setup{}

" use LSP omni-completion in rust files
" autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc

" enable deoplete autocompletion
" let g:deoplete#enable_at_startup = 1

" customize deoplete
" call deoplete#custom#source('_', 'max_menu_width', 80)

" completion options
set completeopt=menuone,noinsert,noselect

lua << EOF
require("nvim-treesitter.configs").setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "vim", "rust", "lua" },
  highlight = {
      enable = true,
	-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
	-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
	-- Using this option may slow down your editor, and you may see some duplicate highlights.
	-- Instead of true it can also be a list of languages
	additional_vim_regex_highlighting = false,
  },
  -- ...
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}
EOF

" avoid extra messages with completion
set shortmess+=c

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua << EOF
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
	autoSetHints = true,
	hover_with_actions = true,
	inlay_hints = {
	    show_parameter_hints = false,
	    parameter_hints_prefix = "",
	    other_hints_prefix = "",
	},
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
	-- on_attach is a callback called when the language server attachs to the buffer
	-- on_attach = on_attach,
	settings = {
	    -- to enable rust-analyzer settings visit:
	    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
	    ["rust-analyzer"] = {
		-- enable clippy on save
		checkOnSave = {
		    command = "clippy"
		},
	    }
	}
    },
}

require('rust-tools').setup(opts)
EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua << EOF
local cmp = require'cmp'
cmp.setup({
    -- Enable LSP snippets
    snippet = {
	expand = function(args)
	    vim.fn["vsnip#anonymous"](args.body)
	end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
	['<C-n>'] = cmp.mapping.select_next_item(),
        -- Add tab support
	-- ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        -- ['<Tab>'] = cmp.mapping.select_next_item(),
	['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
	['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<Tab>'] = cmp.mapping.confirm({
	    behavior = cmp.ConfirmBehavior.Insert,
	    select = true,
	})
    },

    -- Installed sources
    sources = {
	{ name = 'nvim_lsp' },
	{ name = 'vsnip' },
	{ name = 'path' },
	{ name = 'buffer' },
    },
})
EOF

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" format on write
" autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)

lua << EOF
local autosave = require("autosave")

autosave.setup({
    enabled = true,
    execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
    events = {"InsertLeave", "TextChanged"},
    conditions = {
	exists = true,
        filename_is_not = {},
	filetype_is_not = {},
	modifiable = true
    },
    write_all_buffers = false,
    on_off_commands = true,
    clean_command_line_interval = 0,
    debounce_delay = 135
})
EOF

let mapleader="\<SPACE>"

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

set laststatus=3

lua << EOF
local statusline = require('statusline')
statusline.tabline = false
EOF

lua << EOF
require('chartoggle').setup ({
    leader = '<SPACE>', -- you can use any key as Leader
    keys = { ',', ';' } -- Which keys will be toggle end of the line
})
EOF

" reload configuration
nnoremap <silent> <Leader>r :source $MYVIMRC<cr>

if has("linux")
    set guifont=FantasqueSansMono\ Nerd\ Font:h13
else
    set guifont=FantasqueSansMono\ Nerd\ Font:h16
endif

" increase/decrease font size
nnoremap <silent> <c-_> :ZoomIn<cr>
nnoremap <silent> <c--> :ZoomOut<cr>

" toggle relative line numbers
nnoremap <silent> <c-n> :set rnu!<cr>

function Neovide_fullscreen()
    if g:neovide_fullscreen == v:true
	let g:neovide_fullscreen=v:false
    else
	let g:neovide_fullscreen=v:true
    endif
endfunction
map <F11> :call Neovide_fullscreen()<cr>

if has("linux")
    let g:neovide_refresh_rate=60
else
    let g:neovide_refresh_rate=120
endif

let g:neovide_transparency=0.95
let g:neovide_cursor_vfx_mode = "pixiedust"
let g:neovide_cursor_vfx_particle_density=32.0

" Move to previous/next
nnoremap <silent>    <A-,> :BufferPrevious<CR>
nnoremap <silent>    <A-.> :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
nnoremap <silent>    <A->> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <A-1> :BufferGoto 1<CR>
nnoremap <silent>    <A-2> :BufferGoto 2<CR>
nnoremap <silent>    <A-3> :BufferGoto 3<CR>
nnoremap <silent>    <A-4> :BufferGoto 4<CR>
nnoremap <silent>    <A-5> :BufferGoto 5<CR>
nnoremap <silent>    <A-6> :BufferGoto 6<CR>
nnoremap <silent>    <A-7> :BufferGoto 7<CR>
nnoremap <silent>    <A-8> :BufferGoto 8<CR>
nnoremap <silent>    <A-9> :BufferLast<CR>
" Pin/unpin buffer
nnoremap <silent>    <A-p> :BufferPin<CR>
" Close buffer
nnoremap <silent>    <A-c> :BufferClose<CR>
" Wipeout buffer
"                          :BufferWipeout<CR>
" Close commands
"                          :BufferCloseAllButCurrent<CR>
"                          :BufferCloseAllButPinned<CR>
"                          :BufferCloseBuffersLeft<CR>
"                          :BufferCloseBuffersRight<CR>
" Magic buffer-picking mode
nnoremap <silent> <C-s>    :BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <Space>bb :BufferOrderByBufferNumber<CR>
nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>
nnoremap <silent> <Space>bw :BufferOrderByWindowNumber<CR>

" Other:
" :BarbarEnable - enables barbar (enabled by default)
" :BarbarDisable - very bad command, should never be used

lua << EOF
if vim.fn.has('linux') == 1 then
    actualcmd = 'C:\\Program Files\\PowerShell\\7\\pwsh.exe'
else
    actualcmd = '/bin/zsh'
end
require'FTerm'.setup({
    -- cmd = nil,
    cmd = actualcmd,
    border = 'rounded',
    dimensions  = {
	height = 0.9,
	width = 0.9,
    },
})

vim.api.nvim_create_user_command('CargoRun', function()
    require('FTerm').scratch({
	cmd = {
	    'cargo',
	    'run',
	    '--manifest-path',
	    vim.fn.expand('%:h')..'/../Cargo.toml'
	},
	border = 'rounded',
	dimensions = {
	    height = 0.9,
	    width = 0.96,
	},
	blend = 15,
	auto_close = false,
    })
end, { bang = true })

vim.api.nvim_create_user_command('ZXRun', function()
    require('FTerm').scratch({
	cmd = {
	    'sjasmplus',
	    vim.fn.expand('%:p'),
	    '&&',
        'fuse',
	    vim.fn.expand('%:h')..'/load.sna'
	},
	border = 'rounded',
	dimensions = {
	    height = 0.9,
	    width = 0.96,
	},
	blend = 15,
	auto_close = false,
    })
end, { bang = true })
EOF

nnoremap <silent> <Leader>t :CargoRun<CR>
nnoremap <silent> <Leader>a :ZXRun<CR>
nnoremap <silent> <Leader>f :RustFmt<CR>
nnoremap <silent> <Leader>s :Startify<CR>
nnoremap <silent> <Leader>O O<ESC>O
nnoremap <silent> <Leader>o o<ESC>o

set whichwrap+=<,>,h,l,[,]

imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
