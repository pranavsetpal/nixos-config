vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("*") },
})

vim.lsp.enable({ "clangd", "lua_ls", "ruff", "rust_analyzer", "zls" })

require("blink.cmp").setup({
	keymap = {
		preset = "default",

		["<C-Space>"] = { "show" },
		["<C-n>"] = { "cancel" },
		["<C-o>"] = { "accept" },
		["<C-e>"] = { "select_next" },
		["<C-i>"] = { "select_prev" },
		["<A-Space>"] = { "show_documentation" },
		["<A-e>"] = { "scroll_documentation_down" },
		["<A-i>"] = { "scroll_documentation_up" },
	},

	cmdline = { enabled = false },
	fuzzy = { implementation = "prefer_rust" },
})

vim.diagnostic.enable(true)
vim.diagnostic.config({ virtual_text = true })
