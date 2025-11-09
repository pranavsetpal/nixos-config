{
	description = "nixos setup";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager.url = "github:nix-community/home-manager/master";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

		neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
		neovim-nightly.inputs.nixpkgs.follows = "nixpkgs";

		qtile.url = "github:qtile/qtile";
		qtile.inputs.nixpkgs.follows = "nixpkgs";

		zig.url = "github:mitchellh/zig-overlay";
		zig.inputs.nixpkgs.follows = "nixpkgs";

		zls.url = "github:zigtools/zls";
		zls.inputs.nixpkgs.follows = "nixpkgs";
		# zls.inputs.zig-overlay.follows = "zig";

		fenix.url = "github:nix-community/fenix";
		fenix.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, home-manager, neovim-nightly, qtile, zig, zls, fenix, ... }: let
		sysInfo = {
			system = "x86_64-linux";
			hostname = "laptop";
		};
		userInfo = rec {
			name = "pranav";
			fullname = "pranavsetpal";
			email = "pranav@setpal.net";
			homedir = "/home/${name}";
		};

		pkgs = import nixpkgs { stdenv.hostPlatform.system = sysInfo.system; };
		nixos-overlays = [ (final: prev: { qtile-flake = qtile.packages.${sysInfo.system}.default; }) ];
		home-overlays = [
			(final: prev: { neovim-flake = neovim-nightly.packages.${sysInfo.system}.default; })
			zig.overlays.default
			(final: prev: { zls-flake = zls.packages.${sysInfo.system}.default; })
			fenix.overlays.default
		];
	in {
		nixosConfigurations.${sysInfo.hostname} = nixpkgs.lib.nixosSystem {
			system = sysInfo.system;
			specialArgs = { inherit sysInfo userInfo nixos-overlays; };
			modules = [ ./hardware-configuration/asus-ux8402vu.nix ./configuration.nix ];
		};

		homeConfigurations.${userInfo.name} = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;
			extraSpecialArgs = { inherit userInfo home-overlays; };
			modules = [ ./home.nix ];
		};
	};
}
