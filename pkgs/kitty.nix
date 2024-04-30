{ ... }: {
	programs.kitty = {
		enable = true;
		font = {
			name = "JetBrainsMono";
			size = 11;
		};
		settings = {
			confirm_os_window_close = 0;

			disable_ligatures = "always";
			enable_audio_bell = "no";

			# Cursor
			cursor_shape = "underline";
			cursor_beam_thickness = "1.5";
			cursor_underline_thickness = "1.0";

			scrollback_lines = -1; # Infinite Scrollback

			# Theme
			foreground = "#d7deeb";
			background = "#030508";
			selection_foreground = "none";
			selection_background = "none";
						
			color0 = "#282c34"; # black
			color1 = "#e06c75"; # red
			color2 = "#98c379"; # green
			color3 = "#e5c07b"; # yellow
			color4 = "#61afef"; # blue
			color5 = "#be5046"; # magenta
			color6 = "#56b6c2"; # cyan
			color7 = "#979eab"; # white

			color8 = "#393e48"; # black-bright
			color9 = "#d19a66"; # red-bright
			color10 = "#56b6c2"; # green-bright
			color11 = "#e5c07b"; # yellow-bright
			color12 = "#61afef"; # blue-bright
			color13 = "#be5046"; # magenta-bright
			color14 = "#56b6c2"; # cyan-bright
			color15 = "#abb2bf"; # white-bright
		};

		shellIntegration.enableBashIntegration = false;
		keybindings = {
			"super+shift+enter" = "new_os_window_with_cwd";

			"ctrt+shift+t" = "new_tab";
			"ctrt+shift+w" = "close_tab";
			"ctrl+tab" = "next_tab";
			"ctrl+shift+tab" = "previous_tab";
		};
	};
}
