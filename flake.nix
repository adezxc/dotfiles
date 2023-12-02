{
	description = "Nix setup";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

    agenix = {
      url = "github:ryantm/agenix";
    };
	};

	outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, agenix}: let
		inherit (self) outputs;
	in {
		nixosConfigurations = {
			alchemist = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs outputs;};
				modules = [./hosts/alchemist/default.nix
        agenix.nixosModules.default
        {
          environment.systemPackages = [ agenix.packages.x86_64-linux.default ];
        }];
			};
			antimage = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs outputs;};
				modules = [./hosts/antimage/default.nix
        agenix.nixosModules.default
        {
          environment.systemPackages = [ agenix.packages.x86_64-linux.default ];
        }];
			};
		};

		homeConfigurations = {
			"adam@alchemist" = home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
					extraSpecialArgs = {inherit inputs outputs;};
				modules = [./home-manager/linux.nix ./home-manager/default.nix];
			};
			"adam@antimage" = home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
					extraSpecialArgs = {inherit inputs outputs;};
				modules = [./home-manager/linux.nix ./home-manager/default.nix];
			};
		};
	};
}
