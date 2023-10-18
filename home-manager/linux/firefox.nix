{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles = {
      adam.extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      	bitwarden
      	ublock-origin
      	sidebery
      	sponsorblock
      ];
    };
  };
}

