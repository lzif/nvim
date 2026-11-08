local function toggle_oil()
	if vim.bo.filetype == "oil" then
		require("oil").close()
	else
		require("oil").open(vim.fn.getcwd())
	end
end

return {
	"stevearc/oil.nvim",
	lazy = false,
	opts = {
		default_file_explorer = true,
		view_options = {
			show_hidden = true,
		},
		skip_confirm_for_simple_edits = false,
		-- Oil defaults would shadow the config's own keys inside the
		-- explorer: <C-s> is save, <C-h> is clear highlights. Remove
		-- just those two, keep the rest of oil's defaults.
		keymaps = {
			["<C-s>"] = false,
			["<C-h>"] = false,
		},
	},
	keys = {
		{ "<C-n>", toggle_oil, desc = "Toggle file explorer" },
		{ "<leader>e", toggle_oil, desc = "Toggle file explorer" },
	},
}
