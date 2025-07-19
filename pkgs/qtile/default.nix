{ pkgs, ... }: {
	home = {
		packages = with pkgs; [
			python313Packages.xlib
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
