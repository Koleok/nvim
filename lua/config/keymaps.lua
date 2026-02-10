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

vim.keymap.set("n", "<leader>mm", function()
  require("linear-nvim").show_assigned_issues()
end, {
  desc = "Show assigned Linear issues",
})

vim.keymap.set("v", "<leader>mc", function()
  require("linear-nvim").create_issue()
end, {
  desc = "Create Linear issue from selection",
})

vim.keymap.set("n", "<leader>mc", function()
  require("linear-nvim").create_issue()
end, {
  desc = "Create Linear issue",
})

vim.keymap.set("n", "<leader>ms", function()
  require("linear-nvim").show_issue_details()
end, {
  desc = "Show Linear issue details",
})

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

vim.keymap.set("n", "<C-O>", ":lua Snacks.terminal.toggle('lagent')<CR>", {
  desc = "Open lagent pane",
  remap = true,
})

vim.keymap.set("t", "<C-O>", "<Cmd>close<CR>", {
  desc = "Close lagent pane",
  remap = true,
})

vim.keymap.set("n", "<C-P>", ":lua Snacks.terminal.toggle('ss && aider --watch-files -c ~/.aider.conf.yml')<CR>", {
  desc = "Open aider pane",
  remap = true,
})

vim.keymap.set("t", "<C-P>", "<Cmd>close<CR>", {
  desc = "Close aider pane",
  remap = true,
})

vim.keymap.set("n", "<leader>rr", "<Cmd>Rest run<CR>", {
  desc = "Run request (rest.nvim)",
})

vim.keymap.set("n", "<leader>ry", "<Cmd>Rest curl yank<CR>", {
  desc = "Copy curl request under cursor (rest.nvim)",
})

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
    -- Build a minimal mprocs.yaml with one proc per mask command.
    local lines = {}
    for line in io.lines("./maskfile.md") do
      local cmd = line:match("^%s*%#+%s+([%w%-_]+)%s*$")
      if cmd then
        table.insert(lines, "  " .. cmd .. ":")
        table.insert(lines, "    cmd: ['mask', '" .. cmd .. "']")
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
    local tmpconf = tmpdir .. "/mprocs.yaml"
    local yaml = { "procs:" }
    for _, l in ipairs(lines) do
      table.insert(yaml, l)
    end
    vim.fn.writefile(yaml, tmpconf)

    Snacks.terminal.toggle("mprocs -c " .. tmpconf, { win = { style = "split" } })
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

vim.keymap.set("n", "<leader>gb", ":!git branch --show-current | pbcopy<CR>", {
  desc = "Copy branch name to clipboard",
  remap = true,
})

vim.keymap.set("n", "<leader>gpy", ":!gh pr view --json url --jq .url | pbcopy<CR>", {
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
  vim.fn.system("echo '" .. str .. "' | pbcopy")
end

local function get_linear_code(branch)
  return string.match(branch, "([eai]+%-[0-9]+)")
end

local function get_linear_url(issue_code)
  return "https://linear.app/latermavely/issue/" .. issue_code
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

vim.keymap.set(
  "v",
  "<leader>8",
  -- Break into 80w lines separated by `+`
  function()
    local start = vim.fn.getpos("'<")
    local finish = vim.fn.getpos("'>")
    local lines = vim.fn.getline(start[2], finish[2])
    local indent = lines[1]:match("^%s*") or ""
    local full_text = table.concat(lines, "\n")

    local matches = {}
    local raw = ""
    local i = 1
    local pattern = "(['\"`])(([^%1\\]|\\.)*)%1"
    while i <= #full_text do
      local s, e, quote, content = full_text:find(pattern, i)
      if not s then
        break
      end

      table.insert(matches, { s = s, e = e, content = content, quote = quote })

      local unescaped_content = content:gsub("\\" .. quote, quote):gsub("\\\\", "\\")
      raw = raw .. unescaped_content
      i = e + 1
    end

    if #matches == 0 then
      print("No string literals found in selection.")
      return
    end

    local first_match = matches[1]
    local last_match = matches[#matches]
    local template = full_text:sub(1, first_match.s - 1) .. "%%PLACEHOLDER%%" .. full_text:sub(last_match.e + 1)
    local first_quote = first_match.quote
    local width = 80 - #indent - #first_quote * 2 - 3 -- for quotes and " + "

    if width < 10 then
      width = 10
    end

    local chunks = {}
    if #raw > 0 then
      while #raw > 0 do
        local chunk = raw:sub(1, width)
        if #raw > width and chunk:sub(-1) == "\\" then
          chunk = raw:sub(1, width - 1) -- avoid cutting an escape
        end
        table.insert(chunks, chunk)
        raw = raw:sub(#chunk + 1)
      end
    end

    local new_string_lines = {}
    if #chunks > 0 then
      for idx, ch in ipairs(chunks) do
        local escaped_ch = ch:gsub("\\", "\\\\"):gsub(first_quote, "\\" .. first_quote)
        local line = string.format("%s%s%s", first_quote, escaped_ch, first_quote)
        if idx < #chunks then
          line = line .. " +"
        end
        table.insert(new_string_lines, line)
      end
    else
      table.insert(new_string_lines, first_quote .. first_quote) -- empty string
    end

    local new_string_part = table.concat(new_string_lines, "\n" .. indent)
    local new_text = template:gsub("%%PLACEHOLDER%%", new_string_part)

    local final_lines = vim.split(new_text, "\n")

    vim.api.nvim_buf_set_lines(0, start[2] - 1, finish[2], false, final_lines)
  end,
  { noremap = true, silent = true }
)
