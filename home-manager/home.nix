{ pkgs, lib, ... }:
let
  local = pkgs.callPackage ./pkgs { inherit (pkgs) lib; };
in
{
  home.username = "archie";
  home.homeDirectory = "/home/archie";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  programs.yazi = {
    enable = true;
    settings = {
      mgr = {
        show_hidden = true;
        sort_by = "mtime";
        sort_reverse = true;
      };
    };
    flavors = {
      inherit (pkgs.yazi-flavors)
        catppuccin-macchiato
        catppuccin-latte
        ;
    };
    theme.flavor = {
      dark = "catppuccin-macchiato";
      light = "catppuccin-latte";
    };    
  };
  
  home.shell.enableFishIntegration = true;

  programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv.enable = true;
  };
    
  nixpkgs.config.allowUnfree = true; 
  home.packages = with pkgs; [
      neofetch
      fish
      stow
      local.berth
      helix
      lazygit
      neofetch
      just
      git
      zellij
      typos-lsp
      nil
      nixd
      ripgrep
      fd
      bat
      wget
      asciinema_3
      fzf
      zoxide
      fuzzel
      mako
      unzip
      lxsession
      minicom
      lazydocker
      devcontainer
   ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/archie/system";
  };
  
  programs.home-manager.enable = true;
}
