{ pkgs, ... }: {
	programs.neovim = {
		enable = true;
		package = pkgs.neovim-flake;
	};
	home = {
		packages = with pkgs; [
			tree-sitter nodejs
			unixtools.xxd # for hex.nvim
		];

		file.".config/nvim" = {
			source = ./nvim;
			recursive = true;
		};
	};
}
