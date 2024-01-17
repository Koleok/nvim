return {
  -- -- add symbols-outline
  -- {
  --   "simrat39/symbols-outline.nvim",
  --   cmd = "SymbolsOutline",
  --   keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
  --   opts = {
  --     -- add your options that should be passed to the setup() function here
  --     position = "right",
  --   },
  -- },
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type lspconfig.options
      servers = {
        sourcekit = {
          cmd = { "xcrun", "/usr/bin/sourcekit-lsp" },
        },
      },
    },
  },
}
