{ config, pkgs, lib, ... }: {
  nix = {
    extraOptions = "experimental-features = nix-command flakes";
    nixPath = ["nixpkgs=${pkgs.path}"];
    gc = {
      automatic = true;
      options = "--max-freed 1G --delete-older-than 7d";
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = (import ./packages.nix) pkgs;

  services.tailscale.enable = true;

  programs.zsh.enable = true;
  fonts.fonts = with pkgs; [
    nerdfonts
      fira-code
      fira-code-symbols
  ];
                            }

