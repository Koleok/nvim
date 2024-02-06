return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {
    -- on_attach = on_attach,
    settings = {
      -- tsserver_file_preferences = {
      --   includeCompletionsForModuleExports = true,
      --
      --   -- inlay hints
      --   includeInlayParameterNameHints = "literals",
      --   includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      --   includeInlayFunctionParameterTypeHints = true,
      --   includeInlayVariableTypeHints = true,
      --   includeInlayVariableTypeHintsWhenTypeMatchesName = false,
      --   includeInlayPropertyDeclarationTypeHints = true,
      --   includeInlayFunctionLikeReturnTypeHints = true,
      --   includeInlayEnumMemberValueHints = true,
      -- },
      -- tsserver_format_options = {
      --   allowIncompleteCompletions = false,
      --   allowRenameOfImportPath = false,
      -- },
    },
  },
}
