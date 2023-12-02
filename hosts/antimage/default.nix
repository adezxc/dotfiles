# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
    lib,
    config,
    pkgs,
    ...
}: {
# You can import other NixOS modules here
  imports = [
  ./hardware-configuration.nix
  ../sound.nix
  ../default.nix
  ];

  nixpkgs = {
# You can add overlays here
    overlays = [
# If you want to use overlays exported from other flakes:
# neovim-nightly-overlay.overlays.default

# Or define it inline, for example:
# (final: prev: {
#   hi = final.hello.overrideAttrs (oldAttrs: {
#     patches = [ ./change-hello-to-hi.patch ];
#   });
# })
    ];
# Configure your nixpkgs instance
    config = {
# Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = {
# This will add each flake input as a registry
# To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

# This will additionally add your inputs to the system's legacy channels
# Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
# Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
# Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

# TODO: Set your hostname
  age.secrets.wireless = {
    file = ../../secrets/wireless.age;
  }; 
  networking.hostName = "antimage";
  networking.wireless.enable = true;
  networking.wireless.userControlled.enable = true;
  networking.wireless.environmentFile = config.age.secrets.wireless.path;
  networking.wireless.networks = {
    home.auth = ''
      ssid="@HOME_WIFI_SSID@"
      scan_ssid=1
      key_mgmt=WPA-PSK
      psk="@HOME_WIFI_PASSWORD@"
      '';
      eduroam.auth = ''
      key_mgmt=WPA-EAP
      eap=MSCHAPV2
      identity="@UNIVERSITY_EMAIL@"
      password="@UNIVERSITY_PASSWORD@"
      '';
      phone.auth = ''
      ssid="@PHONE_HOTSPOT_SSID@"
      key_mgmt=WPA-PSK
      password="@PHONE_HOTSPOT_PASSWORD@"
      '';
  };

# TODO: This is just an example, be sure to use whatever bootloader you prefer
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  environment.systemPackages = (import ./packages.nix) pkgs;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

# TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users.adam = {
    initialHashedPassword = "$y$j9T$IyaOP6tjKlN0bKsMFicqc/$5wLBBz3CB.OOkElgaLLND2KkIUcF.QrGv5N1k2ygbn2";
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
    ];
    extraGroups = ["wheel" "multimedia"];
    shell = pkgs.zsh;
    home = "/home/adam";
  };

programs.zsh.enable = true;

programs.gnupg.agent = {
  enable = true;
};

services.xserver = {
  displayManager = {
    sessionCommands = ''
      ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
         *dpi: 120
          Xft.dpi: 120
          ''}
    '';
  };
};


time.timeZone = "Europe/Vilnius";

# Select internationalisation properties.
i18n.defaultLocale = "en_US.UTF-8";

services.tailscale.enable = true;

hardware.opengl = {
  enable = true;
  driSupport = true;
  driSupport32Bit = true;
};

# This setups a SSH server. Very important if you're setting up a headless system.
# Feel free to remove if you don't need it.
services.openssh = {
  enable = true;
# Forbid root login through SSH.
  settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = false;
  };    # Use keys only. Remove if you want to SSH using password (not recommended)
};

# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
system.stateVersion = "23.05";
}
