{ userInfo, ... }: {
  services.syncthing = {
    enable = true;
    user = userInfo.name;
    dataDir = userInfo.homedir;

    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        mobile.id = "TVDG3ZB-PJAC6NR-RIY3FND-VAFMUWO-2ZIYHIL-JH4UR5S-EKY4OP6-6RFQYAU";
      };
      folders = {
        keepass = {
          path = "${userInfo.homedir}/.keepassxc";
          devices = [ "mobile" ];
        };
        misc = {
          path = "${userInfo.homedir}/share/mobile";
          devices = [ "mobile" ];
        };
      };
    };
  };
}

