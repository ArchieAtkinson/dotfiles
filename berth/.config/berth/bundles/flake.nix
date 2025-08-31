{
  description = "Generate .deb packages for specified applications";

  inputs = {
    nixpkgs.url = "nixpkgs";
    bundlers = {
      url = "github:NixOS/bundlers";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, bundlers }:
  let
    supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
    forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
  in {
    packages = forAllSystems (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        toDEB = bundlers.bundlers.${system}.toDEB;

        apps = {
          helix   = pkgs.helix;
          yazi    = pkgs.yazi;
          lazygit = pkgs.lazygit;
          typos-lsp = pkgs.typos-lsp;
        };

        # Rename keys to *-deb so they’re easy to find/build
        debs = pkgs.lib.mapAttrs' (name: drv: {
          name = "${name}-deb";
          value = toDEB drv;
        }) apps;
      in
        debs
    );
  };
}
