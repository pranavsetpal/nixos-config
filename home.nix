{ lib, pkgs, userInfo, flake-overlays, ... }: {
	home.stateVersion = "24.05";
	programs.home-manager.enable = true;
	fonts.fontconfig.enable = true;

	imports = [
		./pkgs/gpg.nix
		./pkgs/neovim
		./pkgs/git.nix
		./pkgs/bash
		./pkgs/qtile
		./pkgs/xkb
		./pkgs/xdg.nix
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
			permittedInsecurePackages = [ "cinny-${pkgs.cinny-desktop.version}" "cinny-unwrapped-${pkgs.cinny-desktop.version}" ];
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
			texliveFull python312Packages.pygments typst
			multiviewer-for-f1
			cmus
			obsidian
			libreoffice
			gimp
			obs-studio
			zoom-us
			qbittorrent

			signal-desktop
			cinny-desktop
			(vesktop.override { withSystemVencord = true; })

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
			sage fricas
			go
			jdk
			openssl

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
			NIXOS_OZONE_WL=1;
			# env_name = "env_val";
		};
	};

	news.display = "silent";
}
