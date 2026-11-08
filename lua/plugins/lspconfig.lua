return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "mason-org/mason-lspconfig.nvim" },
		{ "folke/lazydev.nvim" },
	},
	cmd = { "LspInfo", "LspInstall", "LspUninstall" },
	event = { "BufReadPre", "BufNewFile" },
	init = function()
		vim.diagnostic.config({
			virtual_text = false,
			severity_sort = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "✘",
					[vim.diagnostic.severity.WARN] = "▲",
					[vim.diagnostic.severity.HINT] = "⚑",
					[vim.diagnostic.severity.INFO] = "»",
				},
			},
			float = {
				border = "rounded",
				source = true,
			},
		})
	end,
	config = function()
		local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("NvimPolishLspAttach", { clear = true }),
			callback = function(event)
				local opts = { buffer = event.buf }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
				vim.keymap.set(
					"n",
					"gD",
					vim.lsp.buf.declaration,
					vim.tbl_extend("force", opts, { desc = "Go to declaration" })
				)
				vim.keymap.set(
					"n",
					"gi",
					vim.lsp.buf.implementation,
					vim.tbl_extend("force", opts, { desc = "Go to implementation" })
				)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Find references" }))
				vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))
				vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
				vim.keymap.set(
					"n",
					"<leader>la",
					vim.lsp.buf.code_action,
					vim.tbl_extend("force", opts, { desc = "Code action" })
				)
			end,
		})

		-- Config before mason setup: enable can trigger an immediate start
		-- for already-open buffers, so the safe order is config first.
		vim.lsp.config("*", { capabilities = lsp_capabilities })
		vim.lsp.config("emmet_language_server", {
			filetypes = {
				"css",
				"eruby",
				"html",
				"javascript",
				"javascriptreact",
				"less",
				"sass",
				"scss",
				"pug",
				"typescriptreact",
				"svelte",
				"astro",
				"htmlangular",
				"htmldjango",
				"templ",
				"vue",
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"emmet_language_server",
				"svelte",
				"lua_ls",
				"gopls",
				"rust_analyzer",
			},
			automatic_enable = {
				exclude = { "ts_ls" },
			},
		})
	end,
}
