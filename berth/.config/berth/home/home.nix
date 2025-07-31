{ config, pkgs, ... }:

{
  home.username = "user";
  home.homeDirectory = "/home/user";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # programs.fish.enable = true;

  home.packages = with pkgs; [
      fish
      helix
      lazygit
      neofetch
      just
      git
      zellij
      typos-lsp
      nil
      ripgrep
      fd
      bat
      wget
      asciinema_3
      fzf
  ];

  home.file = {
  };

  home.sessionVariables = {
  };
  
  programs.home-manager.enable = true;
}
