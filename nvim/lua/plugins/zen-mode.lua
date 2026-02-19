return {
  "folke/zen-mode.nvim",
  config = function()
    require("zen-mode").setup({
      window = {
        width = 0.85,
        height = 0.9,
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
        twilight = { enabled = false },
        gitsigns = { enabled = false },
      },
      on_open = function(win)
        vim.opt.conceallevel = 2
        vim.opt.wrap = true
        vim.opt.number = false
      end,
      on_close = function()
        vim.opt.conceallevel = 0
        vim.opt.wrap = false
        vim.opt.number = true
      end,
    })

    -- Toggle zen mode with <leader>z
    vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "Toggle Zen Mode" })
  end,
}
