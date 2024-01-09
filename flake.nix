{
  description = "basic nixos install flake";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      # url = "github:nix-community/home-manager/master";
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: 
    let
      userInfo = rec {
        name = "pranav";
        fullname = "pranavsetpal";
        email = "pranav.setpal@gmail.com";
        homedir = "/home/${name}";
      };
    in {
      nixosConfigurations.portable = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit userInfo; };
        modules = [
          ./nixos-config.nix

          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit userInfo; };
              users."${userInfo.name}".imports = [ ./hm-config.nix ];
            };
          }
        ];
      };
    };
}
