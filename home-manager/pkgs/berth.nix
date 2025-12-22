{ pkgs }:

pkgs.rustPlatform.buildRustPackage {
  pname = "berth";
  version = "c1621ccd9f5415fcb75a5a97b518c78464598cd5";

  src = pkgs.fetchFromGitHub {
    owner = "ArchieAtkinson";
    repo = "berth";
    rev = "c1621ccd9f5415fcb75a5a97b518c78464598cd5";
    sha256 = "sha256-HDzklPmLIG7ZPMNzJXNyCCUkzgT5TcQxpuWgPPE51Lk=";
  };
  doCheck = false;
  cargoHash = "sha256-LBBVFIkQ2oC5Bnbt23waIQjnBTTjksyJgEaYlF7mKDw=";
}

