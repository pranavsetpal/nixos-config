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
			extraPortals = [ pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk ];
			config.common.default = [ "wlr" "gtk" ];
		};
	};

	home.sessionVariables.XDG_CURRENT_DESKTOP = "qtile:wlroots:gtk";
}
