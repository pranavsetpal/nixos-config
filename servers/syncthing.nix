{ userInfo, ... }: {
	services.syncthing = {
		enable = true;
		user = userInfo.name;
		dataDir = userInfo.homedir;

		overrideDevices = true;
		overrideFolders = true;
		settings = {
			devices = {
				mobile.id = "Y5X6XKG-INSDGSF-GHMDC2W-L7PP5QA-YJ56ZLB-RERBLFG-V25ZTEV-XRIGYQ7";
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
