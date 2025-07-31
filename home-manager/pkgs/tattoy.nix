{ pkgs }:

pkgs.rustPlatform.buildRustPackage {
  pname = "tattoy";
  version = "tattoy-v0.1.8";

  src = pkgs.fetchFromGitHub {
    owner = "tattoy-org";
    repo = "tattoy";
    rev = "tattoy-v0.1.8";
    sha256 = "sha256-44rXygZVbwwC/jOB69iHydsjYr/WeVU4Eky3BPqJzyc=";
  };
  doCheck = false;

  buildInputs = [
    pkgs.dbus
    pkgs.xorg.libxcb

  ];

  nativeBuildInputs = [ pkgs.pkg-config ];

  preConfigure = ''
    export PKG_CONFIG_PATH="${pkgs.dbus.dev}/lib/pkgconfig"
  '';

  cargoHash = "sha256-DJyml8J9XXKD2t1dQz+OrVDFcq6PLMoDlhiLo86D3CM=";
}

