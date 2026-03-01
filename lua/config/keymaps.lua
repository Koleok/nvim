-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Better move line from Ben 🙌 ty!
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Keep cursor in the center of the screen when moving up and down
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- For moving to different window
-- vim.keymap.set("n", "<C-=>", [[<cmd>vertical resize +5<cr>]]) -- make the window biger vertically
-- vim.keymap.set("n", "<C-->", [[<cmd>vertical resize -5<cr>]]) -- make the window smaller vertically
-- vim.keymap.set("n", "<C-+>", [[<cmd>horizontal resize +2<cr>]]) -- make the window bigger horizontally by pressing shift and =
-- vim.keymap.set("n", "<C-_>", [[<cmd>horizontal resize -2<cr>]]) -- make the window smaller horizontally by pressing shift and -

vim.keymap.set("v", "<leader>lu", ":!awk '!seen[$0]++'", {
  desc = "Remove duplicated lines",
  remap = true,
})

vim.keymap.set("n", "<C-y>", ":lua Snacks.terminal.toggle('lazydocker', { win = { style = \"split\"}})<CR>", {
  desc = "Toggle docker pane",
  remap = true,
})

vim.keymap.set("t", "<C-y>", "<Cmd>close<CR>", {
  desc = "Close docker pane",
  remap = true,
})

vim.keymap.set("n", "<C-p>", ":lua Snacks.terminal.toggle('aider --watch-files -c ~/.aider.conf.yml')<CR>", {
  desc = "Toggle aider pane",
  remap = true,
})

vim.keymap.set("t", "<C-p>", "<Cmd>close<CR>", {
  desc = "Close aider pane",
  remap = true,
})

local mask_tmpconf = nil
vim.keymap.set("n", "<C-i>", function()
  local has_package_json = vim.fn.filereadable("./package.json") == 1
  local has_npm_scripts = false

  if has_package_json then
    vim.fn.system("jq -e '.scripts != null and (.scripts | length > 0)' ./package.json 2>/dev/null")
    has_npm_scripts = vim.v.shell_error == 0
  end

  local has_mprocs_config = vim.fn.filereadable("./mprocs.yaml") == 1
  local has_maskfile = vim.fn.filereadable("./maskfile.md") == 1

  if has_mprocs_config then
    Snacks.terminal.toggle("mprocs", { win = { style = "split" } })
  elseif has_npm_scripts then
    Snacks.terminal.toggle("mprocs --npm", { win = { style = "split" } })
  elseif has_maskfile then
    if not mask_tmpconf then
      local in_code_block = false
      local commands = {}
      local current_parent = nil
      local current_child = nil

      for line in io.lines("./maskfile.md") do
        if line:match("^```") then
          in_code_block = not in_code_block
          if in_code_block then
            if current_child then
              current_child.has_code = true
            elseif current_parent then
              current_parent.has_code = true
            end
          end
        end

        if not in_code_block then
          local hashes, cmd = line:match("^%s*(#+)%s+([%w%-_][%w%-_ ]*)%s*$")
          if hashes and cmd then
            cmd = cmd:match("^(.-)%s*$") -- trim trailing space
            local depth = #hashes
            if depth == 2 then
              current_child = nil
              current_parent = { name = cmd, has_code = false, children = {} }
              table.insert(commands, current_parent)
            elseif depth == 3 and current_parent then
              current_child = { name = cmd, has_code = false }
              table.insert(current_parent.children, current_child)
            end
          end
        end
      end

      local lines = {}
      for _, parent in ipairs(commands) do
        local valid_children = {}
        for _, child in ipairs(parent.children) do
          if child.has_code then
            table.insert(valid_children, child)
          end
        end

        if #valid_children > 0 then
          for _, child in ipairs(valid_children) do
            local cmd_parts = {}
            for part in child.name:gmatch("%S+") do
              table.insert(cmd_parts, "'" .. part .. "'")
            end
            table.insert(lines, "  " .. child.name .. ":")
            table.insert(lines, "    cmd: ['mask', " .. table.concat(cmd_parts, ", ") .. "]")
            table.insert(lines, "    stop: { send-keys: ['<C-c>'] }")
            table.insert(lines, "    autostart: false")
          end
        elseif parent.has_code then
          table.insert(lines, "  " .. parent.name .. ":")
          table.insert(lines, "    cmd: ['mask', '" .. parent.name .. "']")
          table.insert(lines, "    stop: { send-keys: ['<C-c>'] }")
          table.insert(lines, "    autostart: false")
        end
      end

      if #lines == 0 then
        print("maskfile.md found but no commands detected")
        return
      end

      local tmpdir = vim.fn.tempname()
      vim.fn.mkdir(tmpdir, "p")
      mask_tmpconf = tmpdir .. "/mprocs.yaml"
      local yaml = { "procs:" }
      for _, l in ipairs(lines) do
        table.insert(yaml, l)
      end
      vim.fn.writefile(yaml, mask_tmpconf)
    end

    Snacks.terminal.toggle("mprocs -c " .. mask_tmpconf, { win = { style = "split" } })
  else
    print("mprocs requires either a package.json with scripts, a maskfile.md or an mprocs.yaml config file")
  end
end, {
  desc = "Run mprocs with smart detection",
  remap = true,
})

vim.keymap.set("t", "<C-i>", "<Cmd>close<CR>", {
  desc = "Close mprocs pane",
  remap = true,
})

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

vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTags<CR>", {
  remap = true,
  desc = "Pick from obsidian tags",
})

vim.keymap.set("n", "<leader>oh", "<cmd>ObsidianTOC<CR>", {
  remap = true,
  desc = "Pick from obsidian TOC",
})

vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", {
  remap = true,
  desc = "Pick from obsidian links",
})

-- Yank the current filepath to the clipboard
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

vim.keymap.set("n", "<leader>gpo", ":!gh pr view --web<CR>", {
  desc = "Open the github PR for current branch",
  remap = true,
})

vim.keymap.set("n", "<leader>gb", ":!git branch --show-current | wl-copy<CR>", {
  desc = "Copy branch name to clipboard",
  remap = true,
})

vim.keymap.set("n", "<leader>gpy", ":!gh pr view --json url --jq .url | wl-copy<CR>", {
  desc = "Copy the github PR url to the clipboard",
  remap = true,
})

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

local function copy_to_clipboard(str)
  vim.fn.system("echo '" .. str .. "' | wl-copy")
end

local function get_linear_code(branch)
  return string.match(branch, "([a-z]+%-[0-9]+)")
end

local function get_linear_url(issue_code)
  return "https://linear.app/privy/issue/" .. issue_code
end

vim.keymap.set("n", "<leader>gio", function()
  local branch = get_current_branch()

  if branch then
    local issue_code = get_linear_code(branch)

    if issue_code then
      local linear_url = get_linear_url(issue_code)
      vim.fn.jobstart({ "open", linear_url }, { detach = true })
    else
      print("Unable to determine Linear URL for the current branch.")
    end
  end
end, {
  desc = "Open the linear issue url for this branch",
  remap = true,
})

vim.keymap.set("n", "<leader>giy", function()
  local branch = get_current_branch()

  if branch then
    local issue_code = get_linear_code(branch)

    if issue_code then
      local linear_url = get_linear_url(issue_code)
      local md_link = "[" .. issue_code .. "](" .. linear_url .. ")"
      copy_to_clipboard(md_link)
      print("Copied " .. linear_url .. " to the clipboard as md link")
    else
      print("Unable to determine Linear URL for the current branch.")
    end
  end
end, {
  desc = "Copy the linear issue url url to the clipboard",
  remap = true,
})

vim.keymap.set("n", "<leader>gu", function()
  local github_url = get_github_url()

  if github_url then
    copy_to_clipboard(github_url)
    vim.fn.jobstart({ "open", github_url }, { detach = true })
  else
    print("Unable to determine GitHub URL for the current repository.")
  end
end, {
  desc = "Open current file on github remote",
  remap = true,
})

vim.keymap.set("n", "<leader>gwl", function()
  require("telescope").extensions.git_worktree.git_worktrees()
end, {
  desc = "Select worktree",
  remap = true,
})

vim.keymap.set("n", "<leader>gwc", function()
  require("telescope").extensions.git_worktree.create_git_worktree()
end, {
  desc = "Create new worktree",
  remap = true,
})
