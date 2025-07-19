{ pkgs, ... }: {
	home.packages = with pkgs; [ xdg-utils ];
	xdg = {
		mime.enable = true;
		mimeApps.defaultApplications = {
			# Default Browser
			"text/html" = "librewolf.desktop";
			"x-scheme-handler/http" = "librewolf.desktop";
			"x-scheme-handler/https" = "librewolf.desktop";
			"x-scheme-handler/about" = "librewolf.desktop";
			"x-scheme-handler/unknown" = "librewolf.desktop";
		};

		portal = {
			enable = true;
			extraPortals = with pkgs; [ xdg-desktop-portal-wlr xdg-desktop-portal-gtk ];
			config.common.default = [ "wlr" "gtk" ];
		};
	};

	home.sessionVariables = {
		XDG_CURRENT_DESKTOP = "qtile";
		XDG_SESSION_TYPE = "wayland";
		
		# Sets Wayland as default
		GDK_BACKEND = "wayland,x11";
		MOZ_ENABLE_WAYLAND = 1;
		ELECTRON_OZONE_PLATFORM_HINT = "auto";
		SDL_VIDEODRIVER = "wayland,x11";
		NIXOS_OZONE_WL = 1;
	};
}
