-- The plugin manager setup, defining the list of plugins.
-- This function is what gets executed when `require("config.lazy")` is called.
return require("lazy").setup({
    -- Here is the plugin list (your existing treesitter plugin goes here)
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        -- Recommended: configure treesitter right here, or in another config file
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "vim", "vimdoc" }, -- Add languages you use
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                },
            })
        end,
    },

    -- Add more plugins here (e.g., LSPs, completion, etc.)
    -- { "my-plugin/my-plugin-repo" }

})
