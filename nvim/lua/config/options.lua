-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

-- disable standard file tree
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.hlsearch = false
opt.incsearch = true
vim.opt.scrolloff = 8
vim.lsp.Inlayhints = false
