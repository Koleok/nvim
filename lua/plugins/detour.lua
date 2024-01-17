return {
  {
    "carbon-steel/detour.nvim",
    config = function()
      vim.keymap.set("n", "<C-w><enter>", ":Detour<cr>")
    end,
  },
}
