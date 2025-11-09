{ pkgs, ... }: {
	services.xserver = {
		enable = true;
		windowManager.qtile = {
			enable = true;
			package = pkgs.qtile-flake;
		};
		displayManager.startx.enable = true;
	};
}
