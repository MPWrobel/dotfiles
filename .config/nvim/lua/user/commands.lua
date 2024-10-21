vim.api.nvim_create_user_command(
	'Make',
	function(cmd)
		vim.api.nvim_command("bel sp | exe 'term make " .. cmd.args .. "' | $")
	end,
	{ nargs = '*' }
)
