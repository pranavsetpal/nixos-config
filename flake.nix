{
	description = "nixos setup flake";

	inputs = {
		nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixos-unstable";
		};

		zig-overlay.url = "github:mitchellh/zig-overlay";
	};

	outputs = { self, nixos-unstable, home-manager, zig-overlay, ... }:
		let
			system = "x86_64-linux";
			pkgs = import nixos-unstable {
				inherit system;
				config.allowUnfreePredicate = pkg: builtins.elem(nixos-unstable.lib.getName pkg) [
					"epson-201401w"
				];
			};

			userInfo = rec {
				name = "pranav";
				fullname = "pranavsetpal";
				email = "pranav.setpal@gmail.com";
				homedir = "/home/${name}";
			};
		in {
			nixosConfigurations.portable = nixos-unstable.lib.nixosSystem {
				system = system;
				specialArgs = { inherit pkgs userInfo; };
				modules = [ ./hardware-configuration/portable.nix ./configuration.nix ];
			};

			homeConfigurations.${userInfo.name} = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				extraSpecialArgs = { inherit userInfo zig-overlay; };
				modules = [ ./home.nix ];
			};
		};
}
