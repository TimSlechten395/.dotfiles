-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- local utf8 = require("lua-utf8")

local keymap = vim.keymap

keymap.set({ "i", "v" }, "fj", "<esc>", { desc = "which_key_ignore" })

keymap.set("n", "<leader>J", "mzJ`z")
keymap.set("n", "J", "<C-d>zz")
keymap.set("n", "K", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("n", "<leader>p", '"0P')

keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

local function set_user_var(key, value)
  io.write((string.format("\027]1337;SetUserVar=%s=%s\007", key, vim.base64.encode(tostring(value)))))
end

--- let wezterm know that it has to move panes if neovim did not move pane
--- @param direction 'h'|'j'|'k'|'l'
local function move(direction)
  local last_pane = vim.api.nvim_get_current_win()
  local key = vim.api.nvim_replace_termcodes("<C-W>", true, false, true)
  -- execute window move and wait until execution before returning
  vim.api.nvim_feedkeys(key .. direction, "x", false)
  local new_pane = vim.api.nvim_get_current_win()
  if last_pane == new_pane then
    set_user_var("DIRECTION", direction)
    set_user_var("MOVE", true)
  end
  -- if last_pane == vim.api.nvim_get_current_win() then
  --   set_user_var("DIRECTION", direction)
  --   set_user_var("MOVE", true)
  -- end
end

vim.api.nvim_create_autocmd({ "ExitPre" }, {
  callback = function()
    set_user_var("NVIM", false)
  end,
})

-- set nvim to true so wezterm knows nvim is running
set_user_var("NVIM", true)
keymap.set("n", "<C-h>", function()
  move("h")
end)

keymap.set("n", "<C-j>", function()
  move("j")
end)
keymap.set("n", "<C-k>", function()
  move("k")
end)

keymap.set("n", "<C-l>", function()
  move("l")
end)

-- use ALT + jk to move up and down in things like cmp TODO change so alt can be used for something else
keymap.del({ "i" }, "<A-j>")
keymap.del({ "i" }, "<A-k>")
-- keymap.set("i", "<A-j>", "<Down>", { remap = true })
-- keymap.set("i", "<A-k>", "<Up>", { remap = true })

-- keymap.del("n", "<C-h>")
-- keymap.del("n", "<C-j>")
-- keymap.del("n", "<C-k>")
-- keymap.del("n", "<C-l>")
-- keymap.set({ "n", "t" }, "<C-h>", "")
-- keymap.set({ "n", "t" }, "<C-l>", "")
-- keymap.set({ "n", "t" }, "<C-k>", "")
-- keymap.set({ "n", "t" }, "<C-j>", "")
-- keymap.set({ "n", "t" }, "<C-p>", "")

-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- -- quickfix and location list commands
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- -- this is just criminal
--vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
--
-- this one is quite smart
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

--vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")
