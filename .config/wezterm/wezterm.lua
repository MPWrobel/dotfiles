local wezterm = require('wezterm')

local config = {
	front_end = 'WebGpu',
	font_size                    = 18,
	command_palette_font_size    = 18,
	use_fancy_tab_bar            = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom            = true,
	window_background_opacity    = 0.75,
	macos_window_background_blur = 16,
	window_decorations           = 'RESIZE',
	harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0', 'zero' }
}

local function split_nav(key, dir)
	local function is_vim(pane)
	  return pane:get_user_vars().IS_NVIM == 'true'
	end
	local function move_callback(key, dir)
		return function(win, pane)
			if is_vim(pane) then
				win:perform_action({ SendKey = { key = key, mods = 'CTRL' }, }, pane)
			else
				win:perform_action({ ActivatePaneDirection = dir }, pane)
			end
		end
	end
	return {
		key = key,
		mods = 'CTRL',
		action = wezterm.action_callback(move_callback(key, dir)),
	}
end

local action = wezterm.action

config.keys = {
	{
		key = 'k',
		mods = 'SUPER',
		action = action.ClearScrollback 'ScrollbackAndViewport',
	},
	{
		key = 'v',
		mods = 'CTRL|SHIFT',
		action = action.SplitHorizontal { domain = 'CurrentPaneDomain' }
	},
	{
		key = 's',
		mods = 'CTRL|SHIFT',
		action = action.SplitVertical { domain = 'CurrentPaneDomain' }
	},
	{
		key = 'r',
		mods = 'ALT',
		action = action.ActivateKeyTable {
			name = 'resize_pane',
			one_shot = false,
		},
	},
	split_nav('h', 'Left'),
	split_nav('j', 'Down'),
	split_nav('k', 'Up'),
	split_nav('l', 'Right'),
}

config.key_tables = {
	resize_pane = {
		{ key = 'h',      action = action.AdjustPaneSize { 'Left', 1 } },
		{ key = 'l',      action = action.AdjustPaneSize { 'Right', 1 } },
		{ key = 'k',      action = action.AdjustPaneSize { 'Up', 1 } },
		{ key = 'j',      action = action.AdjustPaneSize { 'Down', 1 } },
		{ key = 'Escape', action = 'PopKeyTable' },
	},
}


return config
