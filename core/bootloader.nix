{ ... }: {
	boot.loader = {
		efi = {
			canTouchEfiVariables = true;
			efiSysMountPoint = "/boot";
		};
		grub = {
			enable = true;
			efiSupport = true;
			device = "nodev";
			splashImage = null;
		};
		timeout = 1;
	};
}
