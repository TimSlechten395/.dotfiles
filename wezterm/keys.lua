local wezterm = require("wezterm") --[[@as Wezterm]]
local act = wezterm.action

local M = {}

M.mod = "SHIFT|CTRL"
-- split where there is the most space
M.smart_split = wezterm.action_callback(function(window, pane)
	local dim = pane:get_dimensions()
	if dim.pixel_height > dim.pixel_width then
		window:perform_action(act.SplitVertical({ domain = "CurrentPaneDomain" }), pane)
	else
		window:perform_action(act.SplitHorizontal({ domain = "CurrentPaneDomain" }), pane)
	end
end)

---@param config Config
---Start the keys
function M.setup(config)
	config.disable_default_key_bindings = true
	config.keys = {
		{ mods = "SHIFT|CTRL", key = "k", action = act.ScrollByPage(-0.5) },
		{ mods = "SHIFT|CTRL", key = "j", action = act.ScrollByPage(0.5) },
		{ mods = M.mod, key = "t", action = act.SpawnTab("CurrentPaneDomain") },

		-- smart split
		{ mods = M.mod, key = "Enter", action = M.smart_split },
		-- Move Tabs
		{ mods = M.mod, key = ">", action = act.MoveTabRelative(1) },
		{ mods = M.mod, key = "<", action = act.MoveTabRelative(-1) },

		-- Activate Tabs
		{ mods = M.mod, key = "h", action = act({ ActivateTabRelative = -1 }) },
		{ mods = M.mod, key = "l", action = act({ ActivateTabRelative = 1 }) },
		{ mods = M.mod, key = "r", action = act.RotatePanes("Clockwise") },
		{ mods = M.mod, key = "s", action = wezterm.action.PaneSelect({}) },
		-- Clipboard
		{ mods = M.mod, key = "c", action = act.CopyTo("Clipboard") },
		{ mods = M.mod, key = "Space", action = act.QuickSelect },
		{ mods = M.mod, key = "X", action = act.ActivateCopyMode },
		{ mods = M.mod, key = "f", action = act.Search("CurrentSelectionOrEmptyString") },
		{ mods = M.mod, key = "v", action = act.PasteFrom("Clipboard") },
		{
			mods = M.mod,
			key = "u",
			action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
		},

		{ mods = M.mod, key = "m", action = act.TogglePaneZoomState },
		{ mods = M.mod, key = "p", action = act.ActivateCommandPalette },
		{ mods = M.mod, key = "d", action = act.ShowDebugOverlay },

		M.split_nav("resize", "CTRL", "LeftArrow", "Right"),
		M.split_nav("resize", "CTRL", "RightArrow", "Left"),
		M.split_nav("resize", "CTRL", "UpArrow", "Up"),
		M.split_nav("resize", "CTRL", "DownArrow", "Down"),
		M.split_nav("move", "CTRL", "h", "Left"),
		M.split_nav("move", "CTRL", "j", "Down"),
		M.split_nav("move", "CTRL", "k", "Up"),
		M.split_nav("move", "CTRL", "l", "Right"),
	}
end

---@param resize_or_move "resize" | "move"
---@param mods string
---@param key string
---@param dir "Right" | "Left" | "Up" | "Down"
function M.split_nav(resize_or_move, mods, key, dir)
	local event = "SplitNav_" .. resize_or_move .. "_" .. dir
	wezterm.on(event, function(win, pane)
		if M.is_nvim(pane) then
			-- pass the keys through to vim/nvim
			-- wezterm.log_error(pane:get_user_vars(), "this should be false")
			win:perform_action({ SendKey = { key = key, mods = mods } }, pane)
		else
			if resize_or_move == "resize" then
				win:perform_action({ AdjustPaneSize = { dir, 3 } }, pane)
			else
				local panes = pane:tab():panes_with_info()
				local is_zoomed = false
				for _, p in ipairs(panes) do
					if p.is_zoomed then
						is_zoomed = true
					end
				end
				wezterm.log_info("is_zoomed: " .. tostring(is_zoomed))
				if is_zoomed then
					dir = dir == "Up" or dir == "Right" and "Next" or "Prev"
					wezterm.log_info("dir: " .. dir)
				end
				win:perform_action({ ActivatePaneDirection = dir }, pane)
				win:perform_action({ SetPaneZoomState = is_zoomed }, pane)
			end
		end
	end)

	-- TODO make neovim tabs and wezterm tabs compatible
	--
	return {
		key = key,
		mods = mods,
		action = wezterm.action.EmitEvent(event),
	}
end

-- if neovim does not activate a different pane make wezterm activate a different pane
wezterm.on("user-var-changed", function(window, pane, name, value)
	if name == "MOVE" and value == "true" then
		local direction = pane:get_user_vars().DIRECTION
		direction = direction == "h" and "Left"
			or direction == "j" and "Down"
			or direction == "k" and "Up"
			or direction == "l" and "Right"
		pane:inject_output(string.format("\027]1337;SetUserVar=%s=%s\007", "MOVE", "ZmFsc2U=")) -- base64 encoding for false
		window:perform_action({ ActivatePaneDirection = direction }, pane)
	end
end)

---
---@param pane Pane
---@return boolean
function M.is_nvim(pane)
	return pane:get_user_vars().NVIM == "true"
end

return M
