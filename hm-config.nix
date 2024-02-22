{ lib, pkgs, stable, userInfo, zig-overlay, ... }: {
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  imports = [
    ./pkgs/neovim
    ./pkgs/bash.nix
    ./pkgs/git.nix
    ./pkgs/xorg.nix
    ./pkgs/qtile
    ./pkgs/kitty.nix
    ./pkgs/pipewire.nix
  ];


  nixpkgs = {
    config.allowUnfreePredicate = pkg: builtins.elem(lib.getName pkg) [
      "obsidian"
    ];
    config.permittedInsecurePackages = [
      "electron-25.9.0"
    ];

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
      ffmpeg

      # Applicaticns
      librewolf ungoogled-chromium
      keepassxc
      mpv
      obs-studio
      obsidian
      libreoffice-fresh

      # Languages
      ccls
      python3
      sage
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
      htop

      # Fonts
      jetbrains-mono
      fira-mono
    ];

    # To add dotfiles not yet supported by home-manager
    file = {
      # ".config/appname".source = dotfiles/appname;
      # ".config/appname".source = dotfiles/appname;
    };

    # Setting session variables
    sessionVariables = {
      EDITOR = "nvim";
      # env_name = "env_val";
    };
  };
  news.display = "silent";
}

