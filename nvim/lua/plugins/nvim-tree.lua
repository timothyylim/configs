return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional for icons
  config = function()
    -- Disable netrw to avoid conflicts with Vex or netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      view = {
        side = "left", -- Open tree on the right
        width = 30,
      },
      update_focused_file = {
        enable = true, -- Follow current file
        update_cwd = true,
      },
      renderer = {
        group_empty = true, -- Collapse empty folders
        icons = {
          show = {
            file = false,
            folder = false,
            folder_arrow = false,
            git = false,
          }
        }
      },
      actions = {
        open_file = {
          quit_on_open = false, -- Keep tree open after opening a file
          window_picker = {
            enable = true, -- Allow picking target window
          },
        },
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        api.config.mappings.default_on_attach(bufnr)
        -- Custom mapping to open file in right pane
        vim.keymap.set("n", "<CR>", function()
          local node = api.tree.get_node_under_cursor()
          vim.cmd("wincmd l") -- Move to right window
          api.node.open.edit(node) -- Open file in right window
        end, opts("Open in right pane"))
        -- Custom mapping to hide/close tree
        vim.keymap.set("n", "<leader>h", api.tree.close, opts("Close tree"))
      end,
    })

    -- Keymap to toggle tree
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { silent = true })
    vim.keymap.set("n", "<leader>f", "<cmd>NvimTreeFocus<CR>", { silent = true, desc = "Focus on NvimTree" })
  end,
}
