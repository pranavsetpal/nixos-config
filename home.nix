{ lib, pkgs, userInfo, zig-overlay, qtile, ... }: {
	home.stateVersion = "24.05";
	programs.home-manager.enable = true;
	fonts.fontconfig.enable = true;

	imports = [
		./pkgs/neovim
		./pkgs/git.nix
		./pkgs/bash
		./pkgs/xdg.nix
		./pkgs/qtile
		./pkgs/xkb
		./pkgs/kitty.nix
		./pkgs/pipewire.nix
	];


	nixpkgs = {
		config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
			"multiviewer-for-f1"
			"obsidian"
			"zoom"
		];

		overlays = [
			zig-overlay.overlays.default
		];
	};

	home = {
		username = userInfo.name;
		homeDirectory = userInfo.homedir;

		packages = with pkgs; [
			# CLI & Maintainence
			pavucontrol
			pandoc
			qpdf zathura
			ffmpeg feh mpv

			# Applications
			librewolf ungoogled-chromium
			keepassxc
			texliveMinimal
			multiviewer-for-f1
			obsidian
			vesktop
			obs-studio
			gimp
			zoom-us

			signal-desktop
			cinny-desktop

			# CLI Fun
			tree
			htop
			cowsay
			lolcat
			fastfetch

			# Dev
			python3
			sage
			zigpkgs.master
			gnumake
			jdk

			# Fonts
			jetbrains-mono
			fira-mono
		];

		# To add dotfiles not yet supported by home-manager
		file = {
			# ".config/appname".source = dotfiles/appname;
			# ".config/appname".source = dotfiles/appname;
		};

		# Setting session variables
		sessionVariables = {
			EDITOR = "nvim";
			# env_name = "env_val";
		};
	};
	news.display = "silent";
}
