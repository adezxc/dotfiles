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

  services.tailscale.enable = true;

  programs.zsh.enable = true;
  fonts.packages = with pkgs; [
    nerdfonts
      fira-code
      fira-code-symbols
  ];
  environment.systemPackages = (import ./packages.nix) pkgs;
  services.xserver = {
    enable = true;
    layout = "pl,lt,ua";
    xkbVariant = ",,phonetic";
    xkbOptions = "grp:alt_shift_toggle";
    displayManager = {
      lightdm = {
        enable = true;
        greeter.enable = true;
        autoLogin = {
          enable = false;
          user = "adam";
        };
      };
    };
    windowManager.i3.enable = true;
  };
}

