{ config, pkgs, lib, ... }: {
  programs.home-manager.enable = true;
  home.stateVersion = "23.05";

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  programs.git = {
    enable = true;
    userName = "Adam Jasinski";
    userEmail = "adam@jasinski.lt"
      aliases = {
        s = "status";
        csm = "commit --signoff -m";
        root = "rev-parse --show-toplevel";
        hash = "rev-parse HEAD";
      };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    initExtra = "source $HOME/.config/zsh/zsh_config";
    dotDir = "~/.config/zsh";
    envExtra = "skip_global_compinit=1";
  };

  programs.alacritty = {
    enable = true;
  };

  programs.starship = {
    enable = true;

    settings = {
      add_newline = true;
      format = ''
        $username$directory$git_branch$git_status$time$status
        $character
        '';
    };
  };


# Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home = {
    username = "adam";
    homeDirectory = "/home/adam";
  };
}
