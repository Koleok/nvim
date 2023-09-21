-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Yank the current filepath to the clipboard
vim.keymap.set("n", "<leader>p", ':let @*=expand("%")<CR>', { desc = "Copy path of open buffer", remap = true })

vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "<C-k>", ":m '<-2<CR>gv=gv")
--
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>cc", "<cmd>(scratch-insert-reuse)", { desc = "Open scratchpad", remap = true })
vim.keymap.set("n", "<leader>uu", "<cmd>Telescope undo<cr>", { desc = "Undo tree (telescope)", remap = true })
