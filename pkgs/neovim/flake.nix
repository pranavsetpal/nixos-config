{
  description = "neovim";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    neovim = {
      url = github:neovim/neovim/stable?dir=contrib;
      inputs.nixpkgs.follows = "nixpkgs";
    }
  };
  outupts = { self, nixpkgs, neovim }: {
    packages.x86_64-linux.default = neov
  };
}
