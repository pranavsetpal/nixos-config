{ ... }: {
  services.xserver.windowManager.qtile = {
    enable = true;
    configFile = ./config.py;
    extraPackages = python311Packages: with python311Packages; [
      dbus-next
      psutil
      pulsectl-asyncio
    ];
  };

  # Compositor
  imports = [ ../picom ];
}
