return {
	"dasupradyumna/midnight.nvim",
	lazy = false,
	priority = 1000,
	config = function() require("midnight").setup({
		Normal		= { bg = "NONE"; },
		StatusLine	= { bg = "NONE"; }
	}) end
}
