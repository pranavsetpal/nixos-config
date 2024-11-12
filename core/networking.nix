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
			extraConfig = "name_servers_append='1.1.1.1'\n";
		};
	};
}
