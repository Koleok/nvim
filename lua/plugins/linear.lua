return {
  {
    "rmanocha/linear-nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("linear-nvim").setup({
        -- optional. regex to use to match against the issue number format for your linear workspace
        issue_regex = "EAI%-%d+",
        -- optional. Fields to fetch when viewing issue details for existing or newly created issues
        issue_fields = { "title", "description" },
        -- optional. Table of default label IDs to apply for each new issue created
        -- default_label_ids = { "abc" },
        -- optional. Sets the logging level for the plugin
        -- log_level = "warn",
      })
    end,
  },
}
