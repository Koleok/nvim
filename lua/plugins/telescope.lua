return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files (but better)" },
  },
  opts = {
    defaults = {
      results_title = false,
      sorting_strategy = "descending",
      layout_strategy = "vertical",
      layout_config = {
        preview_cutoff = 1, -- Preview should always show (unless previewer = false)
        width = 0.90,
        -- prompt + 25 lines of preview + 10 lines for results + buffer
        height = 0.90,
        preview_height = 0.70,
      },
      -- file_ignore_patterns = {
      --   "node_modules",
      --   ".next",
      --   ".expo",
      --   ".turbo",
      --   ".parcel-cache",
      --   ".vercel",
      --   ".svelte-kit",
      -- },
    },
    pickers = {
      find_files = {
        -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
        -- rg --files --hidden --no-ignore --glob "!**/.git/*" --glob '!**/node_modules/*' --glob '!**/.yarn/*'
        layout_srategy = {},
        layout_config = {},
        find_command = {
          "rg",
          "--files",
          "--hidden",
          "--no-ignore",
          "--glob",
          "!**/.git/*",
          "--glob",
          "!**/node_modules/*",
          "--glob",
          "!**/.yarn/*",
          "--glob",
          "!**/.next/*",
        },
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "debugloop/telescope-undo.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("undo")
    end,
    -- keys = {
    -- { "<leader>fh", require("telescope")("find_files", { cwd = false }), desc = "Find Files (with hidden)" },
    -- { "<leader><space>", require("telescope")("files", { cwd = false }), desc = "Find Files (root dir)" },
    -- { "<leader>ff", require("telescope")("files", { cwd = false }), desc = "Find Files (root dir)" },
    -- { "<leader>sg", require("telescope")("live_grep", { cwd = false }), desc = "Grep (root dir)" },
    -- { "<leader>sw", require("telescope")("grep_string", { cwd = false }), desc = "Word (root dir)" },
    -- },
  },
}
