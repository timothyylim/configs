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

vim.g.markdown_folding = 1

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
