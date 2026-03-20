{
  description = "Generate .deb packages for specified applications";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    bundlers = {
      url = "github:NixOS/bundlers";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    portable = {
      url = "github:DavHau/nix-portable";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      bundlers,
      portable,
    }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          toDEB = bundlers.bundlers.${system}.toDEB;
          toArx = bundlers.bundlers.${system}.toArx;
          toPort = portable.bundlers.${system}.default;

          apps = {
            helix = pkgs.helix;
            rsync = pkgs.rsync;
            yazi = pkgs.yazi;
            lazygit = pkgs.lazygit;
            typos-lsp = pkgs.typos-lsp;
          };

          debs = pkgs.lib.mapAttrs' (name: drv: {
            name = "${name}-deb";
            value = toDEB drv;
          }) apps;

          arxs = pkgs.lib.mapAttrs' (name: drv: {
            name = "${name}-arx";
            value = toArx drv;
          }) apps;

          ports = pkgs.lib.mapAttrs' (name: drv: {
            name = "${name}-port";
            value = toPort drv;
          }) apps;

        in
        debs // arxs // ports
      );
    };
}
