{ config, lib, pkgs, sysInfo, userInfo, ... }: {
	system.stateVersion = "24.05";

	imports = [
		# Core services
		./core/bootloader.nix
		./core/networking.nix
		./core/power.nix
		./core/audio.nix
		./core/bluetooth.nix

		# Selfhosted servers
		./servers/unbound.nix
		./servers/syncthing.nix # Requires SYNCTHING_MOBILE_ID set
		# ./servers/searx.nix # Using public instance instead
	];

	time.timeZone = "America/Fort_Wayne";
	# time.timeZone = "Asia/Kolkata";

	i18n.defaultLocale = "en_US.UTF-8";
	# i18n.defaultLocale = "en_IN";
	# i18n.defaultCharacterSet = "UTF-8";

	# Custom keyboard layout for console
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
		extraGroups = [ "wheel" "kvm" "adbusers" "docker" ];
		packages = with pkgs; [ home-manager ];
	};
	programs.adb.enable = true;
	virtualisation.docker.enable = true;

	nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
		"nvidia-x11" "nvidia-settings" "nvidia-persistenced"
	];
	environment.systemPackages = with pkgs; [
		gcc
		file
		killall
		unzip
		git

		v4l-utils

		man-pages man-pages-posix
	];
	programs.nix-ld = {
		enable = true;
		libraries = with pkgs; [ stdenv.cc ];
	};
	documentation.dev.enable = true;

	boot.tmp.cleanOnBoot = true;

	nix = {
		package = pkgs.nixFlakes;
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
