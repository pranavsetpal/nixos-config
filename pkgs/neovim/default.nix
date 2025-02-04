{ lib, pkgs, ... }: {
	programs.neovim.enable = true;
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
