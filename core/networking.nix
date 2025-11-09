{ sysInfo, ... }: {
	networking = {
		hostName = sysInfo.hostname;
		wireless.iwd = {
			enable = true;
			settings = {
				General.EnableNetworkConfiguration = true;
				Network.NameResolvingService= "resolvconf";
			};
		};
		resolvconf = {
			enable = true;
			useLocalResolver = true;
			extraConfig = ''resolv_conf_local_only=NO'';
		};
	};
}
