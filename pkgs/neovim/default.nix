{ lib, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      onedark-nvim # Onedark Colorscheme
      vim-polyglot # Extended syntax highlighting support
      (nvim-treesitter.withPlugins (p: with p; [ bash c lua nix python zig ]))

      # Editing
      vim-closetag # Autoclose tags
      delimitMate # Autoclose brackets/quotes
      nvim-surround # Quick change brackets, quotes, tags
      tcomment_vim # Comment shortcut

      # More than just a Text Editor
      hex-nvim # Hex/Binary support
      # vimtex # LaTeX support
      # (to-come) # Markdown support
      firenvim # Vim Support for Browser Input

      # Lsp
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-path
    ];

    extraLuaConfig = lib.fileContents ./init.lua;
  };

  home.file.".config/nvim/ftdetect/" = {
    source = ./ftdetect;
    recursive = true;
  };
}
