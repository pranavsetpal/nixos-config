{ ... }: {
	xdg.portal = {
		enable = true;
		wlr.enable = true;
		config.common.default = "*";
	};

	environment.sessionVariables.XDG_CURRENT_DESKTOP = "qtile:wlroots";
}
