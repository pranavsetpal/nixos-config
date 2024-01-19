{ lib, inputs, pkgs, stable, userInfo, ... }: {
  system.stateVersion = "23.11";

  imports = [
    ./device/portable.nix

    ./core/bootloader.nix
    ./core/networking.nix
    ./core/power.nix
    ./core/graphics.nix
    ./core/sound.nix
    ./core/bluetooth.nix
    ./core/xserver.nix
  ];

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";
  # i18n.defaultLocale = "en_IN";
  # i18n.defaultCharacterSet = "UTF-8";

  services.xserver = {
    enable = true;
    libinput.enable = true;

    xkb = {
      layout = "us,us,us";
      variant = "colemak_dh,colemak,";
      options = "grp:alt_space_toggle";
    };
  };
  console.useXkbConfig = true;

  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [{
      users = [ userInfo.name ];
      persist = true;
      keepEnv = true;
    }];
  };

  users.users.${userInfo.name} = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [];
  };

  nixpkgs.overlays = [
    (final: prev: { grub2 = stable.grub2; })
  ];
  environment.systemPackages = with pkgs; [
    gcc
    file
    killall
    git

    v4l-utils
  ];

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = " --delete-older-than 16d ";
    };
  };
}

