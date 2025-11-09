{ config, lib, pkgs, modulesPath, sysInfo, ... }: {
	imports = [ 
		(modulesPath + "/installer/scan/not-detected.nix")
		../core/graphics.nix
	];

	boot.kernelPackages = pkgs.linuxPackages_latest;
	# boot.kernelPackages = pkgs.linuxPackages_6_17;

	boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "uas" "sd_mod" "rtsx_pci_sdmmc" ];
	boot.initrd.kernelModules = [ ];
	boot.kernelModules = [ "kvm-intel" ];
	boot.supportedFilesystems = [ "btrfs" ];

	boot.initrd.luks.devices."enc".device = "/dev/disk/by-label/SYSTEM_ENC";

	fileSystems."/boot" =
		{ device = "/dev/disk/by-label/BOOT";
			fsType = "vfat";
			options = [ "fmask=0022" "dmask=0022" ];
		};

	fileSystems."/" =
		{ device = "/dev/disk/by-label/SYSTEM";
			fsType = "btrfs";
			options = [ "subvol=root" "compress=zstd" "noatime" ];
		};

	fileSystems."/home" =
		{ device = "/dev/disk/by-label/SYSTEM";
			fsType = "btrfs";
			options = [ "subvol=home" "compress=zstd" "noatime" ];
		};

	fileSystems."/nix" =
		{ device = "/dev/disk/by-label/SYSTEM";
			fsType = "btrfs";
			options = [ "subvol=nix" "compress=zstd" "noatime" ];
		};

	fileSystems."/var/log" =
		{ device = "/dev/disk/by-label/SYSTEM";
			fsType = "btrfs";
			options = [ "subvol=log" "compress=zstd" "noatime" ];
			neededForBoot = true;
		};

	fileSystems."/swap" =
		{ device = "/dev/disk/by-label/SYSTEM";
			fsType = "btrfs";
			options = [ "subvol=swap" "noatime" ];
		};

	swapDevices = [ { device = "/swap/swapfile"; } ];

	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
