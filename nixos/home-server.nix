# Home media server config
{ config, lib, pkgs, options, ... }:
{
  users.groups.multimedia = { };
  systemd.tmpfiles.rules = [ 
    "d /data 0770 - multimedia - -"
  ];
  services = {
    jellyfin = {
      enable = true;
      group = "multimedia";
      openFirewall = true;
    };

    radarr = {
      enable = true;
      group = "multimedia";
      openFirewall = false;
    };

    sonarr = {
      enable = true;
      group = "multimedia";
      openFirewall = false;
    };

    jackett = {
      enable = true;
      group = "multimedia";
      openFirewall = false;
    };

    transmission = {
      enable = true;
      group = "multimedia";
      openFirewall = false;
      settings = {
        download-dir = "/data/Torrents";
        incomplete-dir = "/data/Torrents-incomplete";
      };
    };

  };
}
