vim.cmd("let g:loaded_perl_provider = 0")
vim.cmd("let g:loaded_ruby_provider = 0")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set number")

vim.opt.wrap = false
vim.o.pumheight = 15

-- =============================== keymappings ==============================


vim.g.mapleader = " "

vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = false })        -- write file
vim.keymap.set('n', '<C-q>', ':q<CR>', { noremap = true, silent = false })        -- quit
vim.keymap.set('n', '<leader>tq', ':tabclose<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-u>', ':u<CR>', { noremap = true, silent = false })        -- undo command
vim.keymap.set('n', '<leader>sa', ':wa<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>wq', ':wqa<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>h', ':split<CR>', { noremap = true, silent = true })

-- ============================ buffers and tabs ===========================
--tabline
vim.keymap.set('n', '<F2>', ':set showtabline=2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<F3>', ':set showtabline=0<CR>', { noremap = true, silent = true })

--tabs
vim.keymap.set('n', '<S-Tab>', ':tabnext<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', '<S-Tab>', ':tabprev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tn', ':tabnew | Alpha<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { noremap = true, silent = true })

-- buffer resize command's
vim.keymap.set('n', '<S-Up', ':resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Down>', ':resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Left>', ':vertical resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Right>', ':vertical resize -2<CR>', { noremap = true, silent = true })

-- switch buffer
--vim.keymap.set('n', '<S-Tab>', ':bprev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })

-- neo-tree
vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>e', ':Neotree focus<CR>', { noremap = true, silent = true })

--git (neogit)
vim.keymap.set('n', '<leader>ng', ':Neogit<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gc', ':Neogit commit<CR>', { noremap = true, silent = true })

--git (diffview)
vim.keymap.set('n', '<leader>fh', ':DiffviewFileHistory<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>df', ':DiffviewFileHistory %<CR>', { noremap = true, silent = true })

--lazy/mason
vim.keymap.set('n', '<leader>lz', ':Lazy<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>mn', ':Mason<CR>', { noremap = true, silent = true })

--home-screen
vim.keymap.set('n', '<leader>hm', ':Alpha<CR>', { noremap = true, silent = true })



vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
