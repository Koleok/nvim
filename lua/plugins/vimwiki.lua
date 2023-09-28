return {
  "vimwiki/vimwiki",
  init = function() --replace 'config' with 'init'
    vim.g.vimwiki_list = { {
      path = "~/personal/mind",
      syntax = "markdown",
      ext = ".md",
    } }
  end,
}
