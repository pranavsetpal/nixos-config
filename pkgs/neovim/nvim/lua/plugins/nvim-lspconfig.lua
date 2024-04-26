return {
	"neovim/nvim-lspconfig",
	dependencies = {{
		"hrsh7th/nvim-cmp", 
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path"
		},

		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-n>"] = cmp.mapping.abort(),
					["<C-o>"] = cmp.mapping.confirm({ select = true }),
					["<C-e>"] = cmp.mapping.select_next_item(),
					["<C-i>"] = cmp.mapping.select_prev_item(),
					["<C-A-e>"] = cmp.mapping.scroll_docs(4),
					["<C-A-i>"] = cmp.mapping.scroll_docs(-4),
				}),
				sources = cmp.config.sources(
					{{ name = "nvim_lsp" }},
					{{ name = "path", options = { trailing_slash = true } }}
				),
				view = {
					entries = {
						name = "custom",
						selection_order = "near_cursor"
					}
				},
				experimental = {
					ghost_text = true
				}
			})
		end
	}},

	config = function()
		local lsp = require("lspconfig")
		lsp.ccls.setup({})
		lsp.ruff.setup({})
		lsp.zls.setup({})

		vim.diagnostic.disable()
	end
}
