{ lib, pkgs, stable, leading, userInfo, zig-overlay, ... }: {
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  imports = [
    ./pkgs/neovim
    ./pkgs/kitty.nix
    ./pkgs/git.nix
    ./pkgs/bash.nix
    ./pkgs/qtile
  ];

  nixpkgs = {
    overlays = [
      zig-overlay.overlays.default
    ];
  };

  home = {
    username = userInfo.name;
    homeDirectory = userInfo.homedir;

    packages = with pkgs; [
      # Utility
      pavucontrol
      android-tools

      # Applicaticns
      librewolf ungoogled-chromium
      keepassxc
      mpv
      obs-studio
      libreoffice-fresh

      # Languages
      ccls
      python3
      # stable.sage
      leading.sage
      zigpkgs.master zls

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
  news.display = "silent";
}

