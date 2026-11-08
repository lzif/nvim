return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({})

		local ok, installed = pcall(function()
			return require("nvim-treesitter")
				.install({
					"javascript",
					"typescript",
					"tsx",
					"lua",
					"svelte",
					"css",
					"html",
					"vimdoc",
					"query",
					"go",
					"rust",
					"toml",
					"json",
					"markdown",
					"markdown_inline",
					"bash",
				})
				:wait(300000)
		end)
		if not ok or installed == false then
			vim.notify(
				"nvim-treesitter: parser install failed or timed out, highlighting may be missing for some filetypes",
				vim.log.levels.WARN
			)
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"go",
				"rust",
				"javascript",
				"typescript",
				"typescriptreact",
				"javascriptreact",
				"lua",
				"svelte",
				"css",
				"html",
				"json",
				"jsonc",
				"toml",
				"markdown",
				"sh",
			},
			callback = function()
				if pcall(vim.treesitter.start) then
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
