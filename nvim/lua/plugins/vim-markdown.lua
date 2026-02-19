return {
  "preservim/vim-markdown",
  ft = "markdown",
  dependencies = { "godlygeek/tabular" },
  init = function()
    vim.g.vim_markdown_no_extensions_in_markdown = 1
    vim.g.vim_markdown_conceal = 1
    vim.g.vim_markdown_folding = 0
  end,
}
