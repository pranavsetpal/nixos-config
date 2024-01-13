{ pkgs, userInfo, ... }: {
  services = {
    xserver = {
      displayManager.startx.enable = true;
      windowManager.qtile = {
        enable = true;
        configFile = ./config.py;
        extraPackages = python3Packages: with pkgs.python3Packages; [
          dbus-next
          psutil
          pulsectl-asyncio
        ];
      };
    };

    picom.enable = true;
  };

  users.users.${userInfo.name}.packages = with pkgs; [
    bemenu
    xclip
    maim
  ];
}
