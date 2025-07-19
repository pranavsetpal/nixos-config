{ userInfo, ... }: {
	services.syncthing = {
		enable = true;
		user = userInfo.name;
		dataDir = userInfo.homedir;

		overrideDevices = true;
		overrideFolders = true;
		settings = {
			devices = { mobile.id = builtins.getEnv "SYNCTHING_MOBILE_ID"; };
			folders = {
				keepass	= { path = "${userInfo.homedir}/.keepassxc";devices = [ "mobile" ]; };
				obsidian= { path = "${userInfo.homedir}/.obsidian";	devices = [ "mobile" ]; };
				purdue	= { path = "${userInfo.homedir}/purdue";	devices = [ "mobile" ]; };
				music	= { path = "${userInfo.homedir}/music";		devices = [ "mobile" ]; };
				share	= { path = "${userInfo.homedir}/mobile";	devices = [ "mobile" ]; };
			};
		};
	};
}
