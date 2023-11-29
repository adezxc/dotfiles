{
	description = "Nix setup";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }: let
		inherit (self) outputs;
	in {
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
