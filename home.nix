{ lib, pkgs, userInfo, flake-overlays, qtile, ... }: {
	home.stateVersion = "24.05";
	programs.home-manager.enable = true;
	fonts.fontconfig.enable = true;

#
	imports = [
		./pkgs/neovim
		./pkgs/git.nix
		./pkgs/bash
		./pkgs/xdg.nix
		./pkgs/qtile
		./pkgs/xkb
		./pkgs/kitty.nix
		./pkgs/pipewire.nix

		./pkgs/zathura.nix
	];


	nixpkgs = {
		config = {
			allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
				"multiviewer-for-f1"
				"obsidian"
				"zoom"
			];
			permittedInsecurePackages = [ "cinny-4.2.2" "cinny-unwrapped-4.2.2" ];
		};

		overlays = flake-overlays;
	};

	home = {
		username = userInfo.name;
		homeDirectory = userInfo.homedir;

		packages = with pkgs; [
			# CLI & Maintainence
			pavucontrol
			pandoc
			qpdf
			ffmpeg feh mpv

			# Applications
			librewolf ungoogled-chromium
			keepassxc
			texliveFull
			multiviewer-for-f1
			obsidian
			libreoffice
			gimp
			obs-studio
			zoom-us
			qbittorrent

			signal-desktop
			cinny-desktop
			telegram-desktop
			vesktop

			# CLI Fun
			tree
			htop
			cowsay
			lolcat
			fastfetch

			# Dev
			gnumake
			zigpkgs.master
			python3
			(sage.override { requireSageTests = false; }) fricas
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
