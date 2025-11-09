{ ... }: {
	services.avahi = {
		enable = true;
		nssmdns4 = true;
		openFirewall = true;
	};
	services.printing.enable = true;
	services.samba.enable = true;
}
