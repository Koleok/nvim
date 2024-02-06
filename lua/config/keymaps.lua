-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Yank the current filepath to the clipboard

vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "<C-k>", ":m '<-2<CR>gv=gv")
--
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- vim.keymap.set("n", "<leader>cc", "<cmd>(scratch-insert-reuse)<cr>", { desc = "Open scratchpad", remap = true })
-- vim.keymap.set("n", "<leader>fh", "<cmd>Telescope find_files<cr>", { desc = "Find files (with hidden)", remap = true })
vim.keymap.set("n", "<leader>uu", "<cmd>Telescope undo<cr>", {
  desc = "Undo tree (telescope)",
  remap = true,
})

vim.keymap.set("n", "<leader>al", "<cmd>LspRestart<cr>", {
  desc = "Restart lsp",
  remap = true,
})

vim.keymap.set("n", "<leader>ap", ':let @*=expand("%")<CR>', {
  desc = "Copy path of open buffer",
  remap = true,
})

vim.keymap.set("n", "<leader>ag", "<C-w>vgd<C-w>l", {
  desc = "Open def in vertical split",
  remap = true,
})

vim.keymap.set("n", "<leader>ad", "<C-w><enter>gd", {
  desc = "Open def in a popup",
  remap = true,
})

vim.keymap.set("n", "<leader>gp", ":!gh pr view --web<CR>", {
  desc = "Open the github PR for current branch",
  remap = true,
})

vim.keymap.set("n", "<leader>gy", ":!gh pr view --json url --jq .url | pbcopy<CR>", {
  desc = "Copy the github PR url to the clipboard",
  remap = true,
})

vim.keymap.set("n", "<leader>gu", function()
  local function get_remote_url()
    local handle = io.popen("git config --get remote.origin.url")
    if handle then
      local result = handle:read("*a")
      local url = result:gsub(":", "/"):gsub("git@", "https://"):gsub("%.git", ""):gsub("%s+", "")
      handle:close()
      return url
    end

    return nil
  end

  local function get_relative_path()
    local repo_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    local file_path = vim.fn.expand("%:p")

    if repo_root ~= "" and string.find(file_path, repo_root, 1, true) == 1 then
      return string.sub(file_path, string.len(repo_root) + 2)
    end

    return nil
  end

  local function get_current_branch()
    local handle = io.popen("git branch --show-current")
    if handle then
      local result = handle:read("*a")
      handle:close()
      return result and result:gsub("\n", "") or nil
    end

    return nil
  end

  local function get_github_url()
    local remote_url = get_remote_url()
    local branch = get_current_branch()

    if not remote_url or not branch then
      return nil
    end

    local relative_path = get_relative_path()

    if not relative_path then
      return nil
    end

    -- GitHub URL format: <remote_url>/blob/<branch>/<relative_path>
    return remote_url .. "/blob/" .. branch .. "/" .. relative_path
  end

  local github_url = get_github_url()

  if github_url then
    vim.cmd(":let @*='" .. github_url .. "'<CR>")
    vim.fn.jobstart({ "open", github_url }, { detach = true })
  else
    print("Unable to determine GitHub URL for the current repository.")
  end
end, {
  desc = "Open current file on github remote",
  remap = true,
})
