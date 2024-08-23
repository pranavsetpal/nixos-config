{ lib, pkgs, userInfo, qtile, ... }: {
	home = {
		packages = with pkgs; [
			(python312Packages.qtile.overrideAttrs { src = qtile.outPath; version = "0.28.1+" + qtile.shortRev; })
			kanshi
			bemenu
			wl-clipboard
			grim slurp
			brightnessctl
		];

		file = {
			".config/qtile" = { source = ./qtile; recursive = true; };
			".config/kanshi" = { source = ./kanshi; recursive = true; };
		};
	};
}
