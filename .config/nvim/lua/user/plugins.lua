require 'user.bootstrap'
require('lazy').setup {
	'tpope/vim-eunuch',
	'nvim-neotest/nvim-nio',
	{
		'stevearc/aerial.nvim',
		opts = {
			on_attach = function(bufnr)
				local keymap = vim.keymap
				keymap.set('n', '<Leader>a', '<Cmd>AerialToggle!<CR>')
				keymap.set('n', '{{', "<cmd>AerialPrev<CR>", { buffer = bufnr })
				keymap.set('n', '}}', "<cmd>AerialNext<CR>", { buffer = bufnr })
			end
		},
	},

	-- Common dependencies
	'nvim-lua/plenary.nvim',
	'nvim-tree/nvim-web-devicons',
	'nvim-neotest/nvim-nio',

	-- Colorscheme
	{
		'mcchrish/zenbones.nvim',
		dependencies = { 'rktjmp/lush.nvim' },
		config = function()
			vim.g.forestbones = {}
			vim.g.zenbones = { transparent_background = true }
		end
	},

	-- Git integration
	'sindrets/diffview.nvim',
	{ 'NeogitOrg/neogit',         config = true },

	-- Language specific
	'kaarmu/typst.vim',
	'SidOfc/mkdx',
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	'Glench/Vim-Jinja2-Syntax',
	'Olical/conjure',
	'folke/neodev.nvim',
	{ 'simrat39/rust-tools.nvim', config = true },
	{
		'lervag/vimtex',
		config = function()
			vim.g.vimtex_view_method = 'skim'

			vim.g.vimtex_compiler_latexmk = {
				build_dir = "build"
			}

			vim.g.vimtex_quickfix_ignore_filters = {
				'DeclareDelimAlias',
				'Overfull',
				'microtype'
			}
		end
	},

	-- Treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require 'user.treesitter'
		end

	},
	'nvim-treesitter/nvim-treesitter-textobjects',
	'windwp/nvim-ts-autotag',

	-- Pairs
	{ 'windwp/nvim-autopairs',  config = true },
	{ 'kylechui/nvim-surround', config = true },

	-- LSP
	'neovim/nvim-lspconfig',
	{ 'williamboman/mason.nvim',         config = true },
	{
		'williamboman/mason-lspconfig.nvim',
		config = function()
			require 'user.lsp'
		end
	},

	-- Autocompletion
	'L3MON4D3/LuaSnip',
	'rafamadriz/friendly-snippets',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'saadparwaiz1/cmp_luasnip',
	{
		'hrsh7th/nvim-cmp',
		config = function()
			require('cmp').setup()
			require 'user.autocomp'
		end
	},

	-- Debugger
	{
		'mfussenegger/nvim-dap',
		config = function()
			require 'user.debug'
		end
	},
	{ 'rcarriga/nvim-dap-ui',            config = true },
	{ 'theHamsta/nvim-dap-virtual-text', config = true },
	{ 'leoluz/nvim-dap-go',              config = true },
	{
		'mfussenegger/nvim-dap-python',
		config = function()
			require('dap-python').setup('/opt/local/bin/python')
		end
	},

	-- FZF
	{
		'nvim-telescope/telescope.nvim',
		config = function()
			require 'user.telescope'
		end
	},
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
		config = function()
			require('telescope').load_extension('fzf')
		end
	},

	-- Colors
	'KabbAmine/vCoolor.vim',

	-- Motions
	{
		'ggandor/leap.nvim',
		init = function()
			require('leap').create_default_mappings()
		end
	},

	'folke/trouble.nvim',

	{
		'mrjones2014/smart-splits.nvim',
		config = function()
			local smartsplits = require 'smart-splits'
			vim.keymap.set('n', '<C-h>', smartsplits.move_cursor_left)
			vim.keymap.set('n', '<C-j>', smartsplits.move_cursor_down)
			vim.keymap.set('n', '<C-k>', smartsplits.move_cursor_up)
			vim.keymap.set('n', '<C-l>', smartsplits.move_cursor_right)
		end
	},

	-- Comments
	{ 'folke/todo-comments.nvim', config = true, event = 'VimEnter' },
	{ 'numToStr/Comment.nvim',    config = true },
}
