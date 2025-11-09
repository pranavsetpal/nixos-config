vim.pack.add({{ src = "https://github.com/dasupradyumna/midnight.nvim" }})

require("midnight").setup({
	Normal		= { bg = "NONE"; },
	StatusLine	= { bg = "NONE"; },
})

vim.cmd("colorscheme midnight")
