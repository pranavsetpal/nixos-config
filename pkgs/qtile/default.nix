{ lib, pkgs, userInfo, qtile, ... }: {
	home = {
		packages = with pkgs; [
			(python312Packages.qtile.overrideAttrs { src = qtile.outPath; version = "0.27.0+" + qtile.shortRev; })
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
