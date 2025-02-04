{ ... }: {
	services.xserver = {
		enable = true;
		windowManager.qtile.enable = true;
		displayManager.startx.enable = true;
	};
}
