{ config, lib, pkgs, sysInfo, userInfo, nixos-overlays, ... }: {
	system.stateVersion = "24.05";

	imports = [
		# Core services
		./core/bootloader.nix
		./core/networking.nix
		./core/power.nix
		./core/audio.nix
		./core/bluetooth.nix
		./core/printing.nix
		./core/qtile.nix

		# Selfhosted servers
		./servers/unbound.nix
		./servers/syncthing.nix # Requires SYNCTHING_MOBILE_ID set
		# ./servers/searx.nix # Using public instance instead
	];

	services.chrony = {
		enable = true;
		# enableNTS = true;
		# servers = [ "time.cloudfare.com" "104.16.132.229" ];
	};
	# time.timeZone = "America/Fort_Wayne";
	time.timeZone = "Asia/Kolkata";

	i18n = {
		defaultLocale = "en_US.UTF-8";
		extraLocales = [ "en_IN/UTF-8" ];
	};

	services.xserver.xkb = {
		layout = "us";
		variant = "colemak_dh";
	};
	console.useXkbConfig = true;

	security.sudo.enable = false;
	security.doas = {
		enable = true;
		extraRules = [{
			users = [ userInfo.name ];
			persist = true;
			keepEnv = true;
		}];
	};

	users.users.${userInfo.name} = {
		isNormalUser = true;
		uid = 1000;
		extraGroups = [ "wheel" "kvm" "adbusers" ];
		packages = with pkgs; [ home-manager ];
	};
	programs.adb.enable = true;

	nixpkgs = {
		overlays = nixos-overlays;
		config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
			"nvidia-x11" "nvidia-settings" "nvidia-persistenced"
		];
	};
	environment.systemPackages = with pkgs; [
		v4l-utils

		gcc
		file
		killall
		unzip
		git

		man-pages man-pages-posix
	];
	programs.nix-ld = {
		enable = true;
		libraries = with pkgs; [ stdenv.cc ];
	};
	documentation.dev.enable = true;

	boot.tmp.cleanOnBoot = true;

	nix = {
		package = pkgs.nixVersions.latest;
		settings = {
			experimental-features = [ "nix-command" "flakes" ];
			auto-optimise-store = true;
		};

		gc = {
			automatic = true;
			dates = "daily";
			options = " --delete-older-than 16d ";
		};
	};
}
