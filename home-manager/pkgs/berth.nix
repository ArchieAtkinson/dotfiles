{ pkgs }:

pkgs.rustPlatform.buildRustPackage {
  pname = "berth";
  version = "05bb4feb86e8e6a0b4b7cc3dec8694b6e9c7552b";

  src = pkgs.fetchFromGitHub {
    owner = "ArchieAtkinson";
    repo = "berth";
    rev = "05bb4feb86e8e6a0b4b7cc3dec8694b6e9c7552b";
    sha256 = "sha256-qIUPqpLPZPyM2U4E7udvnZmZtuaZsPUenE+Oi8KDy5A=";
  };
  doCheck = false;
  cargoHash = "sha256-60yUTXTWk3x7Ua+W8kO/4SniW07VGlDDVijKChHK01Y=";
}

