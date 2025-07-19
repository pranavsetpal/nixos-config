{ lib, pkgs, userInfo, home-overlays, ... }: {
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

		overlays = home-overlays;
	};

	home = {
		username = userInfo.name;
		homeDirectory = userInfo.homedir;

		packages = with pkgs; [
			# CLI
			pavucontrol
			pandoc qpdf
			ffmpeg feh mpv
			rsync
			cmus
			openssl
			simple-scan

			# Applications
			librewolf ungoogled-chromium
			keepassxc
			texliveFull python312Packages.pygments
			multiviewer-for-f1
			libreoffice
			audacity
			obs-studio
			gimp
			(zoom-us.override { pulseaudioSupport = false; xdgDesktopPortalSupport = false; })
			obsidian
			qbittorrent

			thunderbird
			signal-desktop
			cinny-desktop
			(vesktop.override { withSystemVencord = true; })

			# CLI Fun
			nix-tree
			tree
			htop
			cowsay
			lolcat
			fastfetch

			# Dev
			gnumake gef
			zigpkgs.master
			python3
			sage fricas
			go
			jdk

			# Fonts
			jetbrains-mono
			fira-mono
		];

		pointerCursor = {
			package = pkgs.vanilla-dmz;
			name = "DMZ-Black";
			size = 24;
			gtk.enable = true;
		};

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
