{ lib, pkgs, ... }: {
	programs.neovim.enable = true;
	home = {
		packages = with pkgs; [
			ccls
			ruff
			zls

			unixtools.xxd # for hex.nvim
		];

		file.".config/nvim" = {
			source = ./nvim;
			recursive = true;
		};
	};
}
