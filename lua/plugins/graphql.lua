return {
  "letieu/graphql.nvim",
  keys = {
    {
      "<leader>ajg",
      function()
        require("graphql").open()
      end,
      desc = "graphql - Open",
    },
    {
      "<leader>ajq",
      function()
        require("graphql").close()
      end,
      desc = "graphql - Close",
    },
    {
      "<leader>ajr",
      function()
        require("graphql").run()
      end,
      desc = "graphql - Run",
    },
  },
  setup = function()
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#graphql
    require("lspconfig").graphql.setup({})
  end,
}
