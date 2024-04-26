return {
	{
		"m4xshen/autoclose.nvim",
		config = function() require("autoclose").setup({
			options = {
				pair_spaces = true
			}
		}) end
	},
	{
		"kylechui/nvim-surround",
		config = function() require("nvim-surround").setup() end
	},
	{
		"numToStr/Comment.nvim",
		config = function() require("Comment").setup() end
	}
}
