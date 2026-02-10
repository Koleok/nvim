-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
---- Add this to your autocmds.lua
local autocmd = vim.api.nvim_create_autocmd

-- Detect .mdc files as markdown
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.mdc",
  command = "set filetype=markdown",
})
