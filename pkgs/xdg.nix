{ pkgs, ... }: {
	xdg = {
		mimeApps = {
			enable = true;
			defaultApplications = {
				"text/html" = "librewolf.desktop";
			};
		};

		portal = {
			enable = true;
			extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
			config.common.default = [ "wlr" ];
		};
	};

	home.sessionVariables.XDG_CURRENT_DESKTOP = "qtile:wlroots";
}
