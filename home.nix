{ lib, pkgs, userInfo, zig-overlay, qtile, ... }: {
	home.stateVersion = "23.11";
	programs.home-manager.enable = true;
	fonts.fontconfig.enable = true;

	imports = [
		./pkgs/neovim
		./pkgs/git.nix
		./pkgs/shell
		./pkgs/xdg.nix
		./pkgs/qtile
		./pkgs/xkb
		./pkgs/kitty.nix
		./pkgs/pipewire.nix
	];


	nixpkgs = {
		config.allowUnfreePredicate = pkg: builtins.elem(lib.getName pkg) [
			"multiviewer-for-f1"
			"obsidian"
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

			signal-desktop
			cinny-desktop

			# CLI Fun
			tree
			htop
			cowsay
			lolcat
			neofetch

			# Dev
			python3
			(sage.override { requireSageTests = false; })
			zigpkgs.master
			gnumake

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
