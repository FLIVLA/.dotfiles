return {
    "danymat/neogen",
    config = function()
        require('neogen').setup({
            enabled = true,
            languages = {
                javascript = {
                    template = {
                        ['default'] = 'jsdoc',
                    },
                },
                typescript = {
                    template = {
                        ['default'] = 'jsdoc',
                    },
                },
                lua = {
                    template = {
                        ['default'] = 'vimdoc',
                    },
                },
            },
        })
        vim.keymap.set('n', '<leader>do', function()
            require('neogen').generate()
        end)
    end,
}