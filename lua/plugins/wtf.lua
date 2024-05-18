return {
  "piersolenski/wtf.nvim",
  enabled = false,
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  -- opts = function()
  --   local handle = io.popen("pass show api/tokens/openai")
  --
  --   local config = {
  --     search_engine = "duck_duck_go",
  --     openai_api_key = handle and handle:read("*a") or "",
  --     -- other config @ https://github.com/piersolenski/wtf.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
  --   }
  --
  --   return config
  -- end,
  keys = {
    {
      "<leader>xw",
      mode = { "n", "x" },
      function()
        require("wtf").ai()
      end,
      desc = "Debug diagnostic with AI",
    },
    {
      "<leader>xs",
      mode = { "n" },
      function()
        require("wtf").search()
      end,
      desc = "Search diagnostic with Google",
    },
  },
}
