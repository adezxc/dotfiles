{ config, pkgs, lib, ... }: {
  home.stateVersion = "23.05";

  programs.git = {
    enable = true;
    userEmail = "jasinskia@vmware.com";
    userName = "Adam Jasinski";
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
    dotDir = ".config/zsh";
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
}
