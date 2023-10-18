{ config, lib, pkgs, ... }: {
  imports = [
    ./../default.nix
  ];

  services.nix-daemon.enable = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.systemPackages = (import ./packages.nix) pkgs;

  users.users.jasinskia.home = "/Users/jasinskia/";
}
