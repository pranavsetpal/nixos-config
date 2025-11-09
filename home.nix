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
				"slack"
			];
		};

		overlays = home-overlays;
	};

	home = {
		username = userInfo.name;
		homeDirectory = userInfo.homedir;

		packages = with pkgs; [
			# Tools
			pavucontrol
			pandoc qpdf
			ffmpeg feh mpv
			rsync
			cmus
			openssl
			simple-scan
			scrcpy

			# Applications
			librewolf ungoogled-chromium
			keepassxc
			texliveFull python312Packages.pygments
			(multiviewer-for-f1.overrideAttrs {
				version = "2.2.1";
				src = fetchurl {
					url = "https://releases.multiviewer.app/download/295039426/multiviewer_2.2.1_amd64.deb";
					sha256 = "sha256-y40LJVjnkvIxElDooF5xNmpkeVCRRS30o/nvqZnmH+I=";
				};
			})
			libreoffice
			audacity
			obs-studio
			gimp
			(zoom-us.override { pulseaudioSupport = false; xdgDesktopPortalSupport = false; })
			obsidian
			qbittorrent

			signal-desktop
			(vesktop.override { withSystemVencord = true; })
			slack

			# CLI Fun
			nix-tree
			tree
			htop
			cowsay
			lolcat
			fastfetch

			# Dev
			/* c */ gnumake gef clang-tools
			/* go */ go
			/* java */ jdk
			/* lua */ lua-language-server
			/* python */ python3 pwntools ruff (sage.override { requireSageTests = false; }) fricas
			/* rust */ fenix.latest.toolchain
			/* zig */ zigpkgs.master zls-flake

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
