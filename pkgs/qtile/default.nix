{ lib, pkgs, userInfo, qtile, ... }: {
	home = {
		packages = with pkgs; [
			wlr-randr
			bemenu
			wl-clipboard
			grim slurp
			brightnessctl
		];

		file.".config/qtile" = { source = ./qtile; recursive = true; };
		file.".xinitrc".source = ./xinitrc;
	};
}
