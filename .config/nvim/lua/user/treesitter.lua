require 'nvim-treesitter.configs'.setup {
	ensure_installed = {
		'c',
		'css',
		'html',
		'javascript',
		'kotlin',
		'lua',
		'norg',
		'python',
		'rust',
		'query',
	},
	highlight = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				['af'] = '@function.outer',
				['if'] = '@function.inner',
			},
		},
		swap = {
			enable = true,
			swap_next = {
				['<Leader>s'] = '@parameter.inner',
			},
			swap_previous = {
				['<Leader>S'] = '@parameter.inner',
			},
		},
	},
}
