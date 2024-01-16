{ lib, pkgs, ... }: {
  home = {
    packages = with pkgs; [
      qtile
      bemenu
      xclip
      maim
    ];

    file = {
      "~/.config/qtile/config.py".source = ./config.py;
      ".xinitrc".text = "exec qtile start";
    };
  };
}
