{ config, pkgs, lib, ... }: {
  nix = {
    extraOptions = "experimental-features = nix-command flakes";
    nixPath = ["nixpkgs=${pkgs.path}"];
    gc = {
      automatic = true;
      options = "--max-freed 1G --delete-older-than 30d";
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };

  services = {
    resolved = {
      enable = true;
    };
    tailscale.enable = true;
    openssh = {
      enable = true;
      settings.PasswordAuthentication = true;
      settings.KbdInteractiveAuthentication = true;
    };
  };

  programs.zsh.enable = true;
  fonts.packages = with pkgs; [
    nerdfonts
      fira-code
      fira-code-symbols
  ];
  environment.systemPackages = (import ./packages.nix) pkgs;
}

