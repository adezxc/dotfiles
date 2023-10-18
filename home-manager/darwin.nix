{ config, pkgs, lib, ... }: {
  home.stateVersion = "23.05";

  programs.git = {
    enable = true;
    userEmail = "jasinskia@vmware.com";
  };
}
