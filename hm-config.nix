{ lib, pkgs, stable, userInfo, zig-overlay, ... }: {
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  imports = [
    ./pkgs/neovim
    ./pkgs/shell
    ./pkgs/git.nix
    ./pkgs/xorg.nix
    ./pkgs/qtile
    ./pkgs/kitty.nix
    ./pkgs/pipewire.nix
  ];


  nixpkgs = {
    config.allowUnfreePredicate = pkg: builtins.elem(lib.getName pkg) [
      "multiviewer-for-f1"
    ];

    overlays = [
      zig-overlay.overlays.default
    ];
  };

  home = {
    username = userInfo.name;
    homeDirectory = userInfo.homedir;

    packages = with pkgs; [
      # CLI & Maintainence
      pavucontrol
      android-tools
      pandoc
      qpdf zathura
      ffmpeg feh mpv

      # Applications
      librewolf ungoogled-chromium
      keepassxc
      multiviewer-for-f1
      texliveMinimal
      obs-studio
      gimp

      signal-desktop
      cinny-desktop

      # CLI Fun
      tree
      htop
      cowsay
      lolcat
      neofetch

      # Languages + LSP
      ccls
      python3 ruff-lsp
      sage
      zigpkgs.master zls

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
