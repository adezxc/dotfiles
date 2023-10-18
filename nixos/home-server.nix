# Home media server config
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  services.radarr = {
    enable = true;
    openFirewall = false;
  };

  services.sonarr = {
    enable = true;
    openFirewall = false;
  };

  services.jackett = {
    enable = true;
    openFirewall = false;
  };
}
