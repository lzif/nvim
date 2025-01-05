return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
	{
    'akinsho/bufferline.nvim',
		lazy = true,
    event = "BufRead",
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup {
        options = {
					indicator = {
						style = "icon"
					},
          show_close_icon = true,
          diagnostics = "nvim_lsp",
          separator_style = "slant",
      },
    }
    end
  },
	{
		'nvim-lualine/lualine.nvim',
		event = 'VeryLazy',
		opts = {
  	  options = {
      	theme = 'tokyonight',
				icons_enabled = true,
    	  disabled_filetypes = {
      		statusline = {'NvimTree'}
      	}
    	},
    },
		init = function()
		  vim.opt.showmode = false
		end,
  },
	{
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl',
		event = {'BufReadPost', 'BufNewFile'},
		opts = {
			enabled = true,
		  scope = {
		  	enabled = true,
		  },
		  indent = {
		    char = '▏',
		  },
		}
	},
	{
		"windwp/nvim-autopairs",
	  config = function()
    	require("nvim-autopairs").setup({})
	  end
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
	  config = function()
	    local conform = require("conform")
	    conform.setup({
		    log_level = vim.log.levels.DEBUG,
		    formatters_by_ft = {
		    	javascript = { "prettierd" },
		    	typescript = { "prettierd" },
		    	typescriptreact = { "prettierd" },
		    },
			})
			vim.keymap.set({ "n", "v" }, "<C-p>", function()
			  conform.format({
				  lsp_fallback = true,
				  async = false,
				  timeout_ms = 5000,
				})
			end, { desc = "Format file or range (in visual mode)" })
		end,
	},
}
