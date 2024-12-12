-- Pull in the western API
local wezterm = require("wezterm") --[[@as Wezterm]]
local act = wezterm.action
wezterm.log_info("reloading")

-- This will hold the configuration.
local config = wezterm.config_builder()

require("keys").setup(config)

config.scrollback_lines = 10000

config.default_cwd = "/home/tim"

config.wsl_domains = {
	{
		name = "WSL:Debian",
		distribution = "Debian",
		default_cwd = "/home/tim",
	},
}

-- For example, changing the color scheme
config.color_scheme = "Tokyo Night"

-- setting wsl as default shell
-- this is a better way to set wsl as default, it uses shell linux shell integration
config.default_domain = "WSL:Debian"

-- set the terminal font
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 20

-- setting the default working directory

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
wezterm.on("update-right-status", function(window, pane)
	local name = window:active_key_table()
	if name then
		name = "TABLE: " .. name
	end
	window:set_right_status(name or "")
end)

-- local w = require 'wezterm'
-- local a = w.action

-- local function is_inside_vim(pane)
-- 		return pane:get_user_vars().IS_NVIM == "true" or pane:get_foreground_process_name():find("v")
-- end

-- local function is_outside_vim(pane) return not is_inside_vim(pane) end

-- local function bind_if(cond, key, mods, action)
--   local function callback (win, pane)
--     if cond(pane) then
--       win:perform_action(action, pane)
--     else
--       win:perform_action(a.SendKey({key=key, mods=mods}), pane)
--     end
--   end

--   return {key=key, mods=mods, action=w.action_callback(callback)}
-- end
-- a whole lotta keybindings
config.leader = { key = "f", mods = "CTRL" }
-- config.keys = {
-- 	-- move between panes
-- 	-- bind_if(is_outside_vim, 'h', 'CTRL', a.ActivatePaneDirection('Left')),
-- 	-- bind_if(is_outside_vim, 'j', 'CTRL', a.ActivatePaneDirection('Down')),
-- 	-- bind_if(is_outside_vim, 'k', 'CTRL', a.ActivatePaneDirection('Up')),
-- 	-- bind_if(is_outside_vim, 'l', 'CTRL', a.ActivatePaneDirection('Right')),
-- 	{
-- 		key = "h",
-- 		mods = "CTRL",
-- 		action = act.ActivatePaneDirection("Left"),
-- 	},
-- 	{
-- 		key = "j",
-- 		mods = "CTRL",
-- 		action = act.ActivatePaneDirection("Down"),
-- 	},
-- 	{
-- 		key = "k",
-- 		mods = "CTRL",
-- 		action = act.ActivatePaneDirection("Up"),
-- 	},
-- 	{
-- 		key = "l",
-- 		mods = "CTRL",
-- 		action = act.ActivatePaneDirection("Right"),
-- 	},
--
-- 	-- mode until we cancel that mode.
-- 	{
-- 		key = "r",
-- 		mods = "LEADER",
-- 		action = act.ActivateKeyTable({
-- 			name = "resize_pane",
-- 			one_shot = false,
-- 		}),
-- 	},
--
-- 	{
-- 		key = "h",
-- 		mods = "LEADER",
-- 		action = act.SplitPane({
-- 			direction = "Left",
-- 		}),
-- 	},
--
-- 	{
-- 		key = "j",
-- 		mods = "LEADER",
-- 		action = act.SplitPane({
-- 			direction = "Down",
-- 		}),
-- 	},
--
-- 	{
-- 		key = "k",
-- 		mods = "LEADER",
-- 		action = act.SplitPane({
-- 			direction = "Up",
-- 		}),
-- 	},
--
-- 	{
-- 		key = "l",
-- 		mods = "LEADER",
-- 		action = act.SplitPane({
-- 			direction = "Right",
-- 		}),
-- 	},
--
-- 	{
-- 		key = "h",
-- 		mods = "LEADER|CTRL",
-- 		action = act.SplitPane({
-- 			direction = "Left",
-- 			size = { Percent = 25 },
-- 		}),
-- 	},
--
-- 	{
-- 		key = "j",
-- 		mods = "LEADER|CTRL",
-- 		action = act.SplitPane({
-- 			direction = "Down",
-- 			size = { Percent = 25 },
-- 		}),
-- 	},
--
-- 	{
-- 		key = "k",
-- 		mods = "LEADER|CTRL",
-- 		action = act.SplitPane({
-- 			direction = "Up",
-- 			size = { Percent = 25 },
-- 		}),
-- 	},
--
-- 	{
-- 		key = "l",
-- 		mods = "LEADER|CTRL",
-- 		action = act.SplitPane({
-- 			direction = "Right",
-- 			size = { Percent = 25 },
-- 		}),
-- 	},
--
-- 	{
-- 		key = "x",
-- 		mods = "LEADER",
-- 		action = act.CloseCurrentPane({ confirm = false }),
-- 	},
--
-- 	{
-- 		key = "t",
-- 		mods = "LEADER",
-- 		action = act.ActivateKeyTable({
-- 			name = "switch_tab",
-- 		}),
-- 	},
--
-- 	{
-- 		key = "X",
-- 		mods = "LEADER|SHIFT",
-- 		action = act.CloseCurrentTab({ confirm = false }),
-- 	},
-- 	-- CTRL+SHIFT+Space, followed by 'a' will put us in activate-pane
-- 	-- mode until we press some other key or until 1 second (1000ms)
-- 	-- of time elapses
-- }
--
-- config.key_tables = {
-- 	-- Defines the keys that are active in our resize-pane mode.
-- 	-- Since we're likely to want to make multiple adjustments,
-- 	-- we made the activation one_shot=false. We therefore need
-- 	-- to define a key assignment for getting out of this mode.
-- 	-- 'resize_pane' here corresponds to the name="resize_pane" in
-- 	-- the key assignments above.
-- 	resize_pane = {
-- 		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
--
-- 		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
--
-- 		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
--
-- 		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
--
-- 		-- Cancel the mode by pressing escape
-- 		{ key = "q", action = "PopKeyTable" },
-- 	},
--
-- 	switch_tab = {
-- 		{
-- 			key = "h",
-- 			action = act.ActivateTabRelative(-1),
-- 		},
-- 		{
-- 			key = "l",
-- 			action = act.ActivateTabRelative(1),
-- 		},
-- 		{
-- 			key = "t",
-- 			action = act.SpawnTab("CurrentPaneDomain"),
-- 		},
-- 	},
-- }
--
config.launch_menu = {
	{
		args = { "top" },
	},
	{
		label = "do something",
		args = { "ls", "-al" },
		cwd = "/home/tim",

		-- You can override environment variables just for this command
		-- by setting this here.  It has the same semantics as the main
		-- set_environment_variables configuration option described above
		-- set_environment_variables = { FOO = "bar" },
	},
}
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32
config.unzoom_on_switch_pane = true

-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
-- 	-- local title = M.title(tab, max_width)
-- 	local colors = config.resolved_palette
-- 	local active_bg = colors.tab_bar.active_tab.bg_color
-- 	local inactive_bg = colors.tab_bar.inactive_tab.bg_color
--
-- 	local tab_idx = 1
-- 	for i, t in ipairs(tabs) do
-- 		if t.tab_id == tab.tab_id then
-- 			tab_idx = i
-- 			break
-- 		end
-- 	end
-- 	local is_last = tab_idx == #tabs
-- 	local next_tab = tabs[tab_idx + 1]
-- 	local next_is_active = next_tab and next_tab.is_active
-- 	local arrow = (tab.is_active or is_last or next_is_active) and "" or ""
-- 	local arrow_bg = inactive_bg
-- 	local arrow_fg = colors.tab_bar.inactive_tab_edge
--
-- 	if is_last then
-- 		arrow_fg = tab.is_active and active_bg or inactive_bg
-- 		arrow_bg = colors.tab_bar.background
-- 	elseif tab.is_active then
-- 		arrow_bg = inactive_bg
-- 		arrow_fg = active_bg
-- 	elseif next_is_active then
-- 		arrow_bg = active_bg
-- 		arrow_fg = inactive_bg
-- 	end
--
-- 	local ret = tab.is_active
-- 			and {
-- 				{ Attribute = { Intensity = "Bold" } },
-- 				{ Attribute = { Italic = true } },
-- 			}
-- 		or {}
-- 	ret[#ret + 1] = { Text = title }
-- 	ret[#ret + 1] = { Foreground = { Color = arrow_fg } }
-- 	ret[#ret + 1] = { Background = { Color = arrow_bg } }
-- 	ret[#ret + 1] = { Text = arrow }
-- 	return ret
-- end)

return config
