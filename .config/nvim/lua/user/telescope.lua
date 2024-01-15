local actions = require('telescope.actions')
local layout = require('telescope.actions.layout')

require('telescope').setup {
	defaults = {
		layout_strategy = 'flex',
		mappings = {
			n = {
				['<C-c>'] = actions.close,
				['<M-p>'] = layout.toggle_preview
			},
			i = {
				['<M-p>'] = layout.toggle_preview
			}
		}
	},
	pickers = {
		buffers = {
			sort_lastused = true,
			mappings = {
				i = {
					['<M-d>'] = actions.delete_buffer + actions.move_to_top
				}
			}
		}
	}
}
