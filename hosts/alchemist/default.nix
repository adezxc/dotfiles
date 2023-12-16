{
  inputs,
    lib,
    config,
    pkgs,
    ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../default.nix
    ../sound.nix
    ../home-server.nix
  ];

  nixpkgs = {
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
    config = {
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
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  networking.hostName = "alchemist";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = (import ./packages.nix) pkgs;

  users.users.adam = {
    initialHashedPassword = "$y$j9T$IyaOP6tjKlN0bKsMFicqc/$5wLBBz3CB.OOkElgaLLND2KkIUcF.QrGv5N1k2ygbn2";
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
    ];
    extraGroups = ["wheel" "multimedia"];
    shell = pkgs.zsh;
    home = "/home/adam";
  };

programs.gnupg.agent = {
  enable = true;
};

time.timeZone = "Europe/Vilnius";

i18n.defaultLocale = "en_US.UTF-8";

services.tailscale.enable = true;

hardware.opengl = {
  enable = true;
  driSupport = true;
  driSupport32Bit = true;
};

services.openssh = {
  enable = true;
  settings = {
    PermitRootLogin = "no";
  };    
};

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


# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
system.stateVersion = "23.05";
}
