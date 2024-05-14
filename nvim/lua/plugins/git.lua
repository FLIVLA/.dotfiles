return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "sindrets/diffview.nvim", -- optional - Diff integration

            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim", -- optional
            -- "ibhagwan/fzf-lua",     -- optional
        },
        config = true,
    },
    -- {
    --     "lewis6991/gitsigns.nvim",
    --     config = function()
    --         require("gitsigns").setup({
    --             signs = {
    --                 add = { text = "┃" },
    --                 change = { text = "┃" },
    --                 delete = { text = "_" },
    --                 topdelete = { text = "‾" },
    --                 changedelete = { text = "~" },
    --                 untracked = { text = "┆" },
    --             },
    --             signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    --             numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    --             linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    --             word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    --             watch_gitdir = {
    --                 follow_files = true,
    --             },
    --         })
    --     end,
    -- },
}
