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
<<<<<<< HEAD
			ensure_installed = { "asm", "c", "lua", "nix", "python", "zig" }
=======
			ensure_installed = { "asm", "c", "lua", "nix", "python", "zig" },
			highlight = { enable = true },
			incremental_selection = { enable = true }
>>>>>>> 905c465 (nvim: separate config from nix, add asm filetype support; update flake.lock)
		})
	end,
}
