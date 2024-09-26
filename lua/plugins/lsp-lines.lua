return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  enabled = false,
  config = function()
    require("lsp_lines").setup()
  end,
}
