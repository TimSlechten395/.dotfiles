-- Pull in the western API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = {}

-- This is where you actually appy you config choices

-- For example, changing the color scheme
config.color_scheme = "Tokyo Night"

config.max_fps = 120

-- setting wsl as default shell
-- config.default_prog = {'wsl.exe'}

-- this is a better way to set wsl as default, it uses shell linux shell integration
config.default_domain = "WSL:Debian"

-- set the terminal font
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 15

-- setting the default working directory
config.default_cwd = "/home/tim/programming/"

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.enable_scroll_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.freetype_load_target = "HorizontalLcd"

-- Show which key table is active in the status area
-- wezterm.on("update-right-status", function(window, pane)
-- 	local name = window:active_key_table()
-- 	wezterm.log_error(pane:get_user_vars())
-- 	if name then
-- 		name = "TABLE: " .. name
-- 	end
-- 	window:set_right_status(name or "")
-- end)

-- wezterm.on("user-var-changed", function(window, pane, name, value)
-- 	wezterm.log_info("got value", name, value)
--     if
-- end)
-- local w = require 'wezterm'
-- local a = w.action
--
local function is_inside_vim(pane)
	wezterm.log_info("changed")
	return pane:get_user_vars().NVIM == "true" or pane:get_foreground_process_name():find("v")
end

local function is_outside_vim(pane)
	return not is_inside_vim(pane)
end

local function bind_if(cond, key, mods, action)
	wezterm.log_info("hello")
	local function callback(win, pane)
		if cond(pane) then
			win:perform_action(action, pane)
		else
			win:perform_action(a.SendKey({ key = key, mods = mods }), pane)
		end
	end
	return { key = key, mods = mods, action = w.action_callback(callback) }
end
-- a whole lotta keybindings
config.leader = { key = "f", mods = "CTRL" }
config.keys = {
	-- move between panes
	bind_if(is_outside_vim, "h", "CTRL", a.ActivatePaneDirection("Left")),
	bind_if(is_outside_vim, "j", "CTRL", a.ActivatePaneDirection("Down")),
	bind_if(is_outside_vim, "k", "CTRL", a.ActivatePaneDirection("Up")),
	bind_if(is_outside_vim, "l", "CTRL", a.ActivatePaneDirection("Right")),
	{
		key = "h",
		mods = "LEADER",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "l",
		mods = "LEADER",
		action = act.ActivateTabRelative(1),
	},
	-- {
	-- 	key = "h",
	-- 	mods = "CTRL",
	-- 	action = act.ActivatePaneDirection("Left"),
	-- },
	--
	-- {
	-- 	key = "j",
	-- 	mods = "CTRL",
	-- 	action = act.ActivatePaneDirection("Down"),
	-- },
	-- {
	-- 	key = "k",
	-- 	mods = "CTRL",
	-- 	action = act.ActivatePaneDirection("Up"),
	-- },
	-- {
	-- 	key = "l",
	-- 	mods = "CTRL",
	-- 	action = act.ActivatePaneDirection("Right"),
	-- },

	-- mode until we cancel that mode.
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},

	{
		key = "h",
		mods = "LEADER|CTRL",
		action = act.SplitPane({
			direction = "Left",
		}),
	},

	{
		key = "j",
		mods = "LEADER|CTRL",
		action = act.SplitPane({
			direction = "Down",
		}),
	},

	{
		key = "k",
		mods = "LEADER|CTRL",
		action = act.SplitPane({
			direction = "Up",
		}),
	},

	{
		key = "l",
		mods = "LEADER|CTRL",
		action = act.SplitPane({
			direction = "Right",
		}),
	},

	{
		key = "x",
		mods = "LEADER",
		action = act.CloseCurrentPane({ confirm = false }),
	},

	{
		key = "t",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "switch_tab",
		}),
	},

	{
		key = "X",
		mods = "LEADER|SHIFT",
		action = act.CloseCurrentTab({ confirm = false }),
	},
	-- CTRL+SHIFT+Space, followed by 'a' will put us in activate-pane
	-- mode until we press some other key or until 1 second (1000ms)
	-- of time elapses
}

config.key_tables = {
	-- Defines the keys that are active in our resize-pane mode.
	-- Since we're likely to want to make multiple adjustments,
	-- we made the activation one_shot=false. We therefore need
	-- to define a key assignment for getting out of this mode.
	-- 'resize_pane' here corresponds to the name="resize_pane" in
	-- the key assignments above.
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },

		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },

		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },

		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },

		-- Cancel the mode by pressing escape
		{ key = "q", action = "PopKeyTable" },
	},

	switch_tab = {
		{
			key = "h",
			action = act.ActivateTabRelative(-1),
		},
		{
			key = "l",
			action = act.ActivateTabRelative(1),
		},
		{
			key = "t",
			action = act.SpawnTab("CurrentPaneDomain"),
		},
	},
}

return config
