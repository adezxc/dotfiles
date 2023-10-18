# zsh config
{ config, pkgs, ... }:

{
  programs.zsh = {
  enable = true;
  enableAutosuggestions = true;
  enableSyntaxHighlighting = true;
  defaultKeymap = "viins";
  oh-my-zsh = {
    enable = true;
    plugins = [
      "git"
      "golang"
      "docker"
      "ssh-agent"
    ];
    extraConfig = ''
      zstyle :omz:plugins:ssh-agent agent-forwarding yes
      zstyle ':completion:*:*:docker:*' option-stacking yes
      zstyle ':completion:*:*:docker-*:*' option-stacking yes
    '';
    theme = "robbyrussell";
  };
  };
}
