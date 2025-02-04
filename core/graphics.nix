{ config, ... }: {
	hardware.graphics.enable = true;
	services.xserver.videoDrivers = [ "nvidia" ];

	hardware.nvidia = {
		modesetting.enable = true;
		powerManagement = {
			enable = true;
			finegrained = true;
		};
		open = true;
		nvidiaSettings = true;
		package = config.boot.kernelPackages.nvidiaPackages.beta;

		prime = {
			intelBusId = "PCI:0:2:0";
			nvidiaBusId = "PCI:1:0:0";

			offload = {
				enable = true;
				enableOffloadCmd = true;
			};
		};
	};
}
