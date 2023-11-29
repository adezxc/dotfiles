{
	description = "Nix setup";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-darwin = {
			url = "github:LnL7/nix-darwin";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }: let
		inherit (self) outputs;
	in {
		darwinConfigurations."abaddon" = nix-darwin.lib.darwinSystem {
			modules = [
				({config, pkgs, ...}: { nix.registry.nixpkgs.flake = nixpkgs; })
					./nix-darwin/work.nix
					home-manager.darwinModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.jasinskia = import ./home-manager/darwin.nix;
					}
			];

			system.configurationRevision = self.rev or self.dirtyRev or null;

			system.stateVersion = 4;
		};
		darwinPackages = self.darwinConfigurations."abaddon".pkgs;

		nixosConfigurations = {
			alchemist = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs outputs;};
				modules = [./nixos/configuration.nix /etc/nixos/hardware-configuration.nix];
			};
			antimage = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs outputs;};
				modules = [./hosts/antimage/default.nix];
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
