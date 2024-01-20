{ lib, pkgs, stable, userInfo, zig-overlay, ... }: {
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  imports = [
    ./pkgs/neovim
    ./pkgs/kitty.nix
    ./pkgs/git.nix
    ./pkgs/bash
    ./pkgs/qtile
  ];


  nixpkgs.overlays = [
    zig-overlay.overlays.default
  ];

  home = {
    username = userInfo.name;
    homeDirectory = userInfo.homedir;


    packages = with pkgs; [
      # Languages
      ccls
      python3
      stable.sage
      zigpkgs.master zls

      # Applicaticns
      librewolf ungoogled-chromium
      keepassxc
      mpv
      libreoffice-fresh

      # Utility
      pavucontrol
      android-tools

      # Messaging
      signal-desktop
      cinny-desktop
      telegram-desktop

      # CLI Fun
      neofetch
      cowsay
      lolcat
      tree

      # Fonts
      jetbrains-mono
      fira-mono
    ];

    # To add dotfiles not yet supported by home-manager
    file = {
      # "~/.config/appname".source = dotfiles/appname;
      # "~/.config/appname".source = dotfiles/appname;
    };

    # Setting session variables
    sessionVariables = {
      EDITOR = "nvim";
      # env_name = "env_val";
    };
  };
}
