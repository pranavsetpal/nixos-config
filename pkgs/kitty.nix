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
			cursor = "none";
			cursor_shape = "underline";
			cursor_beam_thickness = "1.5";
			cursor_underline_thickness = "1.0";

			# Colorscheme
			foreground = "#b5bdc5"; selection_foreground = "none";
			background = "#080c10"; selection_background = "none";
			color0 = "#181818";
			color1 = "#fa4d56";
			color2 = "#42be65";
			color3 = "#c8b670";
			color4 = "#5080ff";
			color5 = "#a665d0";
			color6 = "#50b0e0";
			color7 = "#b5bdc5";
			color8 = "#525252";
			color9 = "#ff7279";
			color10 = "#7ac098";
			color11 = "#f8e6a0";
			color12 = "#78a9ff";
			color13 = "#a3a0d8";
			color14 = "#9ac6e0";
			color15 = "#e0e0e0";


			scrollback_lines = -1; # Infinite Scrollback
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
