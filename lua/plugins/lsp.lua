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
      inlay_hints = {
        enabled = false,
      },
      servers = {
        -- denols = {},
        -- tsserver = {
        --   settings = {
        --     single_file_support = false,
        --   },
        -- },
        sourcekit = {
          cmd = { "xcrun", "/usr/bin/sourcekit-lsp" },
        },
        solidity = {
          cmd = {
            "nomicfoundation-solidity-language-server",
            "--stdio",
          },
          filetypes = { "solidity" },
          root_dir = require("lspconfig").util.find_git_ancestor,
          single_file_support = true,
        },
      },
    },
  },
}
