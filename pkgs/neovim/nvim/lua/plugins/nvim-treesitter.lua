return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects"
	},
	build = function()
		require("nvim-treesitter.install").update({ with_sync = true; })
	end,

	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "asm", "c", "java", "lua", "latex", "nix", "python", "typst", "zig" },
			highlight = { enable = true },
		})
	end,
}
