{ pkgs }:

pkgs.rustPlatform.buildRustPackage {
  pname = "berth";
  version = "50883c6678d149137d85c88ce022633cdb4f91e9";

  src = pkgs.fetchFromGitHub {
    owner = "ArchieAtkinson";
    repo = "berth";
    rev = "50883c6678d149137d85c88ce022633cdb4f91e9";
    sha256 = "sha256-2KZxK6eAyz2y0sc9nmwWRhXlLUWZL5ggTVWxT025O8s=";
  };
  doCheck = false;
  cargoHash = "sha256-60yUTXTWk3x7Ua+W8kO/4SniW07VGlDDVijKChHK01Y=";
}

