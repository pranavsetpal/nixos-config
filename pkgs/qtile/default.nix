{ lib, pkgs, userInfo, ... }: {
  home = {
    packages = with pkgs; [
      python311Packages.qtile
      bemenu
      xclip
      maim
      brightnessctl
    ];

    file = {
      ".config/qtile/config.py".source = ./config.py;
      ".xinitrc".text = /* bash */ "exec qtile start \n";
    };
  };
}
