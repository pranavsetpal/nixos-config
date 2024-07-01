{ lib, pkgs, userInfo, qtile, ... }: {
	home = {
		packages = with pkgs; [
			(python311Packages.qtile.overrideAttrs { src = qtile.outPath; version = "0.26.0+" + qtile.shortRev; })
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
