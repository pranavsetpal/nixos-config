{ userInfo, ... }: {
	services.syncthing = {
		enable = true;
		user = userInfo.name;
		dataDir = userInfo.homedir;

		overrideDevices = true;
		overrideFolders = true;
		settings = {
			devices = {
				mobile.id = builtins.getEnv "SYNCTHING_MOBILE_ID";
			};
			folders = {
				keepass = {
					path = "${userInfo.homedir}/.keepassxc";
					devices = [ "mobile" ];
				};
				obsidian = {
					path = "${userInfo.homedir}/.obsidian";
					devices = [ "mobile" ];
				};
				share = {
					path = "${userInfo.homedir}/share/mobile";
					devices = [ "mobile" ];
				};
			};
		};
	};
}
