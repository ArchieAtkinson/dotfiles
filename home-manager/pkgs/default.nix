{ pkgs, lib }:

let
  localPackagesDir = ./.;
  dirContents = builtins.readDir localPackagesDir;

  allImportedPkgs = lib.mapAttrs (name: type:
    if type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix" then
      let
        attrName = lib.removeSuffix ".nix" name;
      in
      { "${attrName}" = pkgs.callPackage (localPackagesDir + "/${name}") { }; }
    else {}
  ) dirContents;

  importedLocalPkgs = lib.mergeAttrsList (builtins.attrValues allImportedPkgs);
in
importedLocalPkgs
