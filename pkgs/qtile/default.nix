{ lib, pkgs, userInfo, ... }: {
	home = {
		packages = with pkgs; [
			python311Packages.qtile
			bemenu
			wl-clipboard
			grim slurp
			brightnessctl
		];

		file.".config/qtile" = {
			source = ./qtile;
			recursive = true;
		};
	};
}
