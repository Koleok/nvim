return {
  "telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  -- keys = {
  --   { "<leader><space>", require("telescope")("files", { cwd = false }), desc = "Find Files (root dir)" },
  --   { "<leader>ff", require("telescope")("files", { cwd = false }), desc = "Find Files (root dir)" },
  --   { "<leader>sg", require("telescope")("live_grep", { cwd = false }), desc = "Grep (root dir)" },
  --   { "<leader>sw", require("telescope")("grep_string", { cwd = false }), desc = "Word (root dir)" },
  -- },
}
