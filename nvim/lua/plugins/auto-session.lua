return {
	-- "rmagatti/auto-session",
	-- config = function()
	-- 	require("auto-session").setup({
	-- 		auto_restore = false,
	-- 		auto_session_supress_dirs = {
	-- 			"/",
	-- 			"~/",
	-- 			"~/Downloads",
	-- 			"~/.dotfiles",
	-- 			"~/.config",
	-- 		},
	-- 		session_lens = {
	-- 			buftypes_to_ignore = {},
	-- 			load_on_setup = true,
	-- 			theme_conf = { border = true },
	-- 			previewer = false,
	-- 		},
	-- 		vim.keymap.set("n", "<leader>ss", ":SaveSession<CR>", { noremap = true, silent = true }),
	-- 		vim.keymap.set("n", "<leader>rs", ":RestoreSession<CR>", { noremap = true, silent = true }),
	-- 		vim.keymap.set(
	-- 			"n",
	-- 			"<leader>ls",
	-- 			require("auto-session.session-lens").search_session,
	-- 			{ noremap = true, silent = true }
	-- 		),
	-- 	})
	-- end,
}