return {
	'neovim/nvim-lspconfig',
	dependencies =  {
		{'hrsh7th/cmp-nvim-lsp'},
		{'williamboman/mason-lspconfig.nvim'},
	},
	cmd = {'LspInfo', 'LspInstall', 'LspUnInstall'},
	event = {'BufReadPre', 'BufNewFile'},
	init = function()
  	local sign = function(opts)
	    vim.fn.sign_define(opts.name, {
	      texthl = opts.name,
	      text = opts.text,
	      numhl = ''
	    })
	  end

	  sign({name = 'DiagnosticSignError', text = '✘'})
	  sign({name = 'DiagnosticSignWarn', text = '▲'})
	  sign({name = 'DiagnosticSignHint', text = '⚑'})
	  sign({name = 'DiagnosticSignInfo', text = '»'})

	  vim.diagnostic.config({
	    virtual_text = false,
	    severity_sort = true,
	    float = {
	      border = 'rounded',
	      source = 'always',
	    },
	  })

	  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
	    vim.lsp.handlers.hover,
	    {border = 'rounded'}
	  )

  	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
	    vim.lsp.handlers.signature_help,
  	  {border = 'rounded'}
	  )
	end,
	config = function()
	  local lspconfig = require('lspconfig')
	  local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

		lspconfig.rust_analyzer.setup({
			capabilities = lsp_capabilities
		})
	  require('mason-lspconfig').setup({
	    ensure_installed = {
	      'ts_ls',
	    },
	    handlers = {
	      function(server)
	        lspconfig[server].setup({
	          capabilities = lsp_capabilities,
	        })
	      end,
  	    ['ts_ls'] = function()
	        lspconfig.ts_ls.setup({
	          capabilities = lsp_capabilities,
	          settings = {
	            completions = {
	              completeFunctionCalls = true
	            }
	          }
	        })
	      end,
	    }
	  })
	end
}
