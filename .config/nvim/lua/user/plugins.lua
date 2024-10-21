require 'user.bootstrap'

local function cmd(command)
	return '<Cmd>' .. command .. '<CR>'
end

local setup = true
local function _(name)
	return function (opts)
		if type(opts[1]) == 'table' then
			opts.opts =  opts[1]
		elseif type(opts[1]) == 'boolean' or type(opts[1]) == 'function' then
			opts.config = opts[1]
		elseif type(opts[1]) == 'string' then
			local mod = opts[1]
			opts.config = function () require(mod) end
		end

		if opts.g then
			opts.init = function ()
				for k, v in pairs(opts.g) do
					vim.g[k] = v
				end
			end
		end

		opts[1] = name
		return opts
	end
end

require('lazy').setup {
	'tpope/vim-eunuch',
	'tpope/vim-rsi',
	'tpope/vim-sleuth',
	'tpope/vim-fugitive',

	-- Common dependencies
	'nvim-lua/plenary.nvim',
	'nvim-tree/nvim-web-devicons',
	'nvim-neotest/nvim-nio',

	-- Git integration
	'sindrets/diffview.nvim',
	_'NeogitOrg/neogit' {
		setup,
		keys = {
			{ '<Leader>g', cmd'Neogit' },
		},
	},

	-- Language support
	'kaarmu/typst.vim',
	'Glench/Vim-Jinja2-Syntax',

	-- Treesitter
	_'nvim-treesitter/nvim-treesitter' { 'user.treesitter' },
	'nvim-treesitter/nvim-treesitter-textobjects',

	-- Pairs
	_'windwp/nvim-ts-autotag' { setup },
	_'windwp/nvim-autopairs' { setup },
	_'kylechui/nvim-surround' { setup },

	-- LSP
	'neovim/nvim-lspconfig',
	'williamboman/mason.nvim',
	_'williamboman/mason-lspconfig.nvim' {
		'user.lsp',
		lazy = false,
		keys = {
			{ 'gd', vim.lsp.buf.definition },
			{ 'gD', vim.lsp.buf.declaration },
			{ 'gi', vim.lsp.buf.implementation },
			{ 'gr', vim.lsp.buf.references },
			{ 'K', vim.lsp.buf.hover },
			{ '<Leader>h', vim.lsp.buf.signature_help },
			{ '<Leader>D', vim.lsp.buf.type_definition },
			{ '<Leader>f', vim.lsp.buf.format },
			{ '<Leader>rn', vim.lsp.buf.rename },
			{ '<Leader>ca', vim.lsp.buf.code_action },
			{ '<Leader>q', vim.diagnostic.setloclist },
			{ '<Leader>e', vim.diagnostic.open_float },
			{ '[d', vim.diagnostic.goto_prev },
			{ ']d', vim.diagnostic.goto_next },
		},
	},
	_'folke/lazydev.nvim' { setup },

	-- Autocompletion
	_'hrsh7th/nvim-cmp' {
		'user.autocomp',
		dependencies = {
			'L3MON4D3/LuaSnip',
			'rafamadriz/friendly-snippets',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'saadparwaiz1/cmp_luasnip',
		},
	},

	-- Debugger
	_'mfussenegger/nvim-dap' { 'user.debug' },
	_'mfussenegger/nvim-dap-python' {
		function ()
			require('dap-python').setup('/opt/local/bin/python')
		end
	},
	_'rcarriga/nvim-dap-ui' { setup },
	_'theHamsta/nvim-dap-virtual-text' { setup },
	_'leoluz/nvim-dap-go' { setup },

	-- FZF
	_'nvim-telescope/telescope-fzf-native.nvim' { build = 'make' },
	_'nvim-telescope/telescope.nvim' {
		'user.telescope',
		keys = {
			{ '<Leader><Leader>', cmd'Telescope buffers' },
			{ '<Leader>ff', cmd'Telescope find_files' },
			{ '<Leader>fb', cmd'Telescope current_buffer_fuzzy_find' },
			{ '<Leader>fr', cmd'Telescope oldfiles' },
			{ '<Leader>fg', cmd'Telescope live_grep' },
			{ '<Leader>ft', cmd'Telescope filetypesj' },
			{ '<Leader>fm', cmd'Telescope man_pages' },
			{ '<Leader>fh', cmd'Telescope help_rags' },
			{ 'z=', cmd'Telescope spell_suggest' },
		},
	},

	-- Colors
	'KabbAmine/vCoolor.vim',

	-- Motions
	_'ggandor/leap.nvim' {
		keys = {
			{ 's', '<Plug>(leap-forward)', 'Leap forward' },
			{ 'S', '<Plug>(leap-backward)', 'Leap backward' },
			{ 'gs', '<Plug>(leap-from-window)', 'Leap from window' },
		},
	},

	_'folke/trouble.nvim' {
		setup,
		cmd = 'Trouble',
		keys = {
			{ '<Leader>td', cmd'Trouble diagnostics toggle' },
			{ '<Leader>tD', cmd'Trouble diagnostics toggle filter.buf=0' },
			{ '<Leader>tt', cmd'Trouble todo toggle' },
		},
	},

	-- Tmux integration
	_'jpalardy/vim-slime' {
		g = {
			slime_target = 'tmux',
			slime_bracketed_paste = 1,
		},
		keys = {
			{ '<C-c>', '<Plug>SlimeMotionSend' },
			{ '<C-c><C-c>', '<Plug>SlimeLineSend' },
		},
	},
	_'mrjones2014/smart-splits.nvim' {
		keys = {
			{ '<C-h>', cmd'SmartCursorMoveLeft' },
			{ '<C-j>', cmd'SmartCursorMoveDown' },
			{ '<C-k>', cmd'SmartCursorMoveUp' },
			{ '<C-l>', cmd'SmartCursorMoveRight' },
		},
	},

	-- Comments
	_'folke/todo-comments.nvim' { setup, event = 'VimEnter' },
	_'numToStr/Comment.nvim' { setup },

	-- Code formatting
	'sbdchd/neoformat',
	_'lukas-reineke/indent-blankline.nvim' { setup, main = 'ibl' },

	-- Quickfix list
	_'ten3roberts/qf.nvim' {
		setup,
		keys = {
			{ '<Leader>ll', function () require('qf').toggle('l', true) end },
			{ '<Leader>cc', function () require('qf').toggle('c', true) end },
		},
	},
	_'kevinhwang91/nvim-bqf' {
		ft = 'qf',
	},
}
