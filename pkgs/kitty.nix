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
