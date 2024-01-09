{ lib, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
        # Visuals
        onedark-nvim # Onedark Colorscheme
        vim-polyglot # Extended syntax highlighting support
        (nvim-treesitter.withPlugins (p: with p; [ bash c lua nix python zig ]))

        # Editing
        vim-closetag # Autoclose MTHL tags
        delimitMate # Autoclose and manage brackets/quotes
        nvim-surround # Quick change brackets, quotes, tags
        tcomment_vim # Comment shortcut

        # Extend Text Editor Funcatinality
        hex-nvim # Hex/Binary Support
        # vimtex # LaTeX Support
        # (Upcoming) # Markdown Support

        # Lsp
        nvim-lspconfig 
        nvim-cmp
        cmp-nvim-lsp
        cmp-path
    ];
    extraLuaConfig = lib.fileContents ./init.lua;
  };

  # For Language Servers
  home.packages = with pkgs; [
    ccls
    zls
  ];
}
