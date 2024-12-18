-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

-- disable standard file tree
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
-- LSP Server to use for Rust.
-- Set to "bacon-ls" to use bacon-ls instead of rust-analyzer.
-- only for diagnostics. The rest of LSP support will still be
-- provided by rust-analyzer.
vim.g.lazyvim_rust_diagnostics = "bacon-ls"
vim.g.snacks_animate = false

opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.hlsearch = false
opt.incsearch = true
vim.opt.scrolloff = 8

vim.g.codeium_disable_bindings = 1 -- Disable the default bindings if you want to manually configure
vim.g.codeium_port = 5000 -- Set a specific port if the default port is not working (usually 5000)
