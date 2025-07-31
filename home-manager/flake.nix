{
  description = "Home Manager configuration of archie";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-yazi-flavors.url = "github:aguirre-matteo/nix-yazi-flavors";
  };

  outputs =
    { nixpkgs, home-manager, nix-yazi-flavors, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nix-yazi-flavors.overlay ];
      };
    in
    {
      homeConfigurations."archie" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];
      };
    };
}
