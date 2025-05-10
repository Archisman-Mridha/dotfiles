return {
	{
		"j-morano/buffer_manager.nvim",
		opts = function(_, opts)
			local map = vim.keymap.set

			local bmui = require("buffer_manager.ui")

			-- Just the menu
			map({ "t", "n" }, "<M-Space>", bmui.toggle_quick_menu, opts)

			-- Open menu and search
			map({ "t", "n" }, "<M-m>", function()
				bmui.toggle_quick_menu()
				-- wait for the menu to open
				vim.defer_fn(function()
					vim.fn.feedkeys("/")
				end, 50)
			end, opts)

			-- Next/Prev
			map("n", "<M-j>", bmui.nav_next, opts)
			map("n", "<M-k>", bmui.nav_prev, opts)

			return {
				select_menu_item_commands = {
					v = {
						key = "<C-v>",
						command = "vsplit",
					},
					h = {
						key = "<C-h>",
						command = "split",
					},
				},
				focus_alternate_buffer = false,
				short_file_names = false,
				short_term_names = false,
				loop_nav = false,
				highlight = "Normal:BufferManagerBorder",
				win_extra_options = {
					winhighlight = "Normal:BufferManagerNormal",
				},
			}
		end,
	},

	-- Disable bufferline (which shows VSCode like tabs)
	{ "akinsho/bufferline.nvim", enabled = false },
}
