return {
  -- also not working
  -- "joshuavial/aider.nvim",
  -- config = function()
  --   -- set a keybinding for the AiderOpen function
  --   vim.api.nvim_set_keymap("n", "<leader>oa", "<cmd>lua AiderOpen()<cr>", { noremap = true, silent = true })
  --   -- set a keybinding for the AiderBackground function
  --   vim.api.nvim_set_keymap("n", "<leader>ob", "<cmd>lua AiderBackground()<cr>", { noremap = true, silent = true })
  -- end,

  -- did not work well, no reason to troubleshoot
  -- "nekowasabi/aider.vim",
  -- dependencies = "vim-denops/denops.vim",
  -- config = function()
  --   vim.g.aider_command = "aider --no-auto-commits"
  --   vim.g.aider_buffer_open_type = "floating"
  --   vim.g.aider_floatwin_width = 100
  --   vim.g.aider_floatwin_height = 20
  --
  --   vim.api.nvim_create_autocmd("User", {
  --     pattern = "AiderOpen",
  --     callback = function(args)
  --       vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { buffer = args.buf })
  --       vim.keymap.set("n", "<Esc>", "<cmd>AiderHide<CR>", { buffer = args.buf })
  --     end,
  --   })
  --
  --   vim.keymap.set("n", "<leader>at", ":AiderRun<CR>", { noremap = true, silent = true })
  --   vim.keymap.set("n", "<leader>aa", ":AiderAddCurrentFile<CR>", { noremap = true, silent = true })
  --   vim.keymap.set("n", "<leader>ar", ":AiderAddCurrentFileReadOnly<CR>", { noremap = true, silent = true })
  --   vim.keymap.set("n", "<leader>aw", ":AiderAddWeb<CR>", { noremap = true, silent = true })
  --   vim.keymap.set("n", "<leader>ax", ":AiderExit<CR>", { noremap = true, silent = true })
  --   vim.keymap.set("n", "<leader>ai", ":AiderAddIgnoreCurrentFile<CR>", { noremap = true, silent = true })
  --   vim.keymap.set("n", "<leader>aI", ":AiderOpenIgnore<CR>", { noremap = true, silent = true })
  --   vim.keymap.set("n", "<leader>aI", ":AiderPaste<CR>", { noremap = true, silent = true })
  --   vim.keymap.set("n", "<leader>ah", ":AiderHide<CR>", { noremap = true, silent = true })
  --   vim.keymap.set("v", "<leader>av", ":AiderVisualTextWithPrompt<CR>", { noremap = true, silent = true })
  -- end,
}
