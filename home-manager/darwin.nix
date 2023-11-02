{ config, pkgs, lib, ... }: {
  imports = [
   ./default.nix 
  ];

  home.stateVersion = "23.05";

  programs.git = {
    enable = true;
    userEmail = "jasinskia@vmware.com";
  };

  programs.zsh.enable = true;
}
