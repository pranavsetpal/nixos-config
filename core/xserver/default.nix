{ ... }: {
  services.xserver = {
    enable = true;
    libinput.enable = true;

    xkb = {
      layout = "us,us,us";
      variant = "colemak_dh,colemak,";
      options = "grp:alt_space_toggle";
    };

    displayManager.startx.enable = true;
  };
}
