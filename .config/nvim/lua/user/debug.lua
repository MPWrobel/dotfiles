local dap = require 'dap'

dap.adapters.firefox = {
	type = 'executable',
	command = 'firefox-debug-adapter',
}

dap.defaults.firefox.exception_breakpoints = {}

dap.configurations.javascript = {
	{
		name = 'Debug with Firefox',
		type = 'firefox',
		request = 'launch',
		reAttach = true,
		url = 'http://localhost:3000',
		webRoot = '${workspaceFolder}',
	}
}

dap.adapters.codelldb = {
	type = 'server',
	port = "${port}",
	executable = {
		command = '/Users/marcin/.local/share/nvim/mason/packages/codelldb/codelldb',
		args = { "--port", "${port}" },
		-- On windows you may have to uncomment this:
		-- detached = false,
	}
}

dap.configurations.c = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
	},
}

-- function LJ()
-- 	require('dap.ext.vscode').load_launchjs('launch.json', {
-- 		lldb = {'c'}
-- 	})
-- end
--

local keymap = vim.keymap
keymap.set('n', '<Leader>c', dap.continue)
keymap.set('n', '<Leader>r', dap.run_last)
keymap.set('n', '<F10>', dap.step_over)
keymap.set('n', '<F11>', dap.step_into)
keymap.set('n', '<F12>', dap.step_out)
keymap.set('n', '<Leader>b', dap.toggle_breakpoint)
keymap.set('n', '<Leader>lp', function()
	require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end)
keymap.set('n', '<Leader>dr', dap.repl.open)
keymap.set({ 'n', 'v' }, '<Leader>dh', require('dap.ui.widgets').hover)
keymap.set('n', '<Leader>df', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.frames)
end)
keymap.set('n', '<Leader>ds', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.scopes)
end)
