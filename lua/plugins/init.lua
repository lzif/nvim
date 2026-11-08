return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				integrations = {
					cmp = true,
					gitsigns = true,
					treesitter = true,
					indent_blankline = {
						enabled = true,
						colored_indent_levels = true,
					},
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")
			conform.setup({
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 5000,
				},
				log_level = vim.log.levels.WARN,
				formatters_by_ft = {
					javascript = { "biome", "prettierd", stop_after_first = true },
					typescript = { "biome", "prettierd", stop_after_first = true },
					typescriptreact = { "biome", "prettierd", stop_after_first = true },
					svelte = { "prettierd" },
					json = { "biome" },
					lua = { "stylua" },
					css = { "prettierd" },
					go = { "goimports", "gofmt", stop_after_first = true },
					rust = { "rustfmt" },
				},
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {},
		},
	},
}
