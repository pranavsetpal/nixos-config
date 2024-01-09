{ lib, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    plugins = let
      nvim-treesitter-with-plugins = pkgs.vimPlugins.nvim-treesitter.withPlugins (treesitter-plugins:
        with treesitter-plugins; [ bash c nix python zig ]
      );
    in
      with pkgs.vimPlugins; [
        # Visuals
        onedark-nvim # Onedark Colorscheme
        vim-polyglot # Extended syntax highlighting support
        nvim-treesitter-with-plugins

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
}
