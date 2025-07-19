{ pkgs, ... }: {
	services.xserver = {
		enable = true;
		windowManager.qtile = {
			enable = true;
			extraPackages = packages: [ pkgs.python313Packages.xlib ];
		};
		displayManager.startx.enable = true;
	};
}
