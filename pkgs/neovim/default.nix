{ lib, pkgs, ... }: {
	programs.neovim.enable = true;
	home = {
		packages = with pkgs; [
			ccls
			ruff
			zls
		];

		file.".config/nvim" = {
			source = ./nvim;
			recursive = true;
		};
	};
}
