return {
  "epwalsh/obsidian.nvim",
  enabled = false,
  -- lazy = true,
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre ~/personal/mind/**.md",
  --   "BufNewFile ~/personal/mind/**.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/personal/mind",
      },
    },
  },
}
