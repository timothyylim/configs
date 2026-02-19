-- Enable folding with manual method
vim.opt.foldenable = true
vim.opt.foldmethod = "manual"
vim.g.vim_markdown_folding = 0

-- Disable treesitter folding to use manual folds
vim.opt.foldexpr = ""

-- Load the plugin manager setup from lua/config/lazy.lua
-- This line is what was causing your previous "resource not found" error.
require("config.lazy")

-- Support Mac keyboard
vim.opt.clipboard = "unnamedplus"

-- Clears highlight after pressing "Enter"
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR><Esc>", { noremap = true, silent = true })

-- Show status bar only if we're working with two files
vim.opt.laststatus = 1

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- No swap files
vim.opt.swapfile = false

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.textwidth = 0
        vim.opt_local.wrapmargin = 0
    end,
})

-- Force Neovim to use standard terminal colors, not 24-bit True Color
vim.opt.termguicolors = false

function prose(opts)
    vim.opt.conceallevel = 2
    vim.opt.wrap = true
    vim.opt.number = false
end

vim.api.nvim_create_user_command('Prose', prose, {})

-- Activate prose mode automatically for markdown files
local prose_group = vim.api.nvim_create_augroup("prose", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" },
    { pattern = { "*.md", "*.txt" }, callback = prose, group = prose_group })

-- Auto-reload files when changed externally (useful when LLMs are editing files)
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "FocusGained", "BufEnter" }, {
  pattern = "*",
  command = "checktime",
})

-- Custom gf for markdown links (resolves relative to file directory)
vim.keymap.set('n', 'gf', function()
  local line = vim.fn.getline('.')
  local col = vim.fn.col('.')

  -- Extract markdown link: [text](path)
  local path = line:match('%]%(([^)]+)%)')

  if path then
    -- Get directory of current file
    local dir = vim.fn.expand('%:p:h')
    -- Resolve path relative to file directory
    local full_path = dir .. '/' .. path
    vim.cmd('edit ' .. full_path)
  else
    -- Fallback to default gf
    vim.cmd('normal! gf')
  end
end, { noremap = true })

-- Override vim-markdown's fold settings - force manual folds for markdown
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md",
  callback = function()
    vim.schedule(function()
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.foldexpr = ""
    end)
  end,
})

-- Auto-enable zen mode when opening a file from command line (but not nvim-tree)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Only enable if a file was opened (not empty buffer) and not a directory
    if vim.fn.argc() > 0 and vim.fn.isdirectory(vim.fn.argv(0)) == 0 then
      vim.defer_fn(function()
        -- Don't enable zen mode if nvim-tree is open
        local is_nvim_tree = vim.bo.filetype == "NvimTree"
        if not is_nvim_tree then
          vim.cmd("silent! ZenMode")
        end
      end, 50)
    end
  end,
})
