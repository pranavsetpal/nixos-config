{ pkgs, ... }: {
	home.packages = with pkgs; [ xdg-utils ];
	xdg = {
		mime.enable = true;
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
