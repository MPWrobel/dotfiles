" OS clipboard
set clipboard=unnamedplus

" Tab indentation
set shiftwidth=4
set tabstop=4

" Window title
set title
set titlestring=%t

" 24-bit colors
set termguicolors

" Line numbers
set number
set relativenumber

" Ignore case when searching by default
set ignorecase
set smartcase

" Enable hiding & replacing concealed text
set conceallevel=2

" Undo history persits after closing a file
set undofile

" Vertical marker to avoid long lines
set colorcolumn=80

" Line wrapping behaviour
set nowrap
set linebreak
set breakindent

" set list
" set listchars=tab:\ \ ,lead:·,trail:·

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable

" Remove search highlight
nnoremap <silent> <Esc> <Cmd>noh<CR>

" Swap j, k & hj, hk behaviour
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Easier window switching
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Terminal mode mappings
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <C-l><C-l> <C-l>

" Save the buffer and run make
noremap <Leader>m <Cmd>w<CR>:Make<CR>

" Scroll one line at a time
noremap <ScrollWheelUp> <C-y>
noremap <ScrollWheelDown> <C-e>

noremap <Leader>tt <Cmd>TroubleToggle<CR>
noremap <Leader>td <Cmd>TodoLocList<CR>

" Telescope
noremap <Leader><Leader> <Cmd>Telescope buffers<CR>
noremap <Leader>ff <Cmd>Telescope find_files<CR>
noremap <Leader>fb <Cmd>Telescope current_buffer_fuzzy_find<CR>
noremap <Leader>fr <Cmd>Telescope oldfiles<CR>
noremap <Leader>fg <Cmd>Telescope live_grep<CR>
noremap <Leader>ft <Cmd>Telescope filetypes<CR>
noremap <Leader>fm <Cmd>Telescope man_pages<CR>
noremap <Leader>fh <Cmd>Telescope help_tags<CR>
noremap z= <Cmd>Telescope spell_suggest<CR>

" LaTeX
noremap <Leader>vc <Cmd>VimtexCompile<CR>

" Git
noremap <Leader>g <Cmd>Neogit<CR>

lua require 'user.plugins'
lua require 'user.commands'
colorscheme kanagawabones
