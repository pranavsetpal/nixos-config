local autocmd = vim.api.nvim_create_autocmd
local filetypes = { "asm", "c", "java", "lua", "nix", "python", "rust", "zig" }

vim.pack.add({{
	src = "https://github.com/nvim-treesitter/nvim-treesitter",
	version = "main",
	data = {
		run = function() vim.cmd("TSUpdate") end,
	},
}})

require("nvim-treesitter").install(filetypes)

-- Enable Treesitter Syntax Highlighting
autocmd("FileType", {
	pattern = filetypes,
	callback = function() vim.treesitter.start() end,
})

-- Use Treesitter folding
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
