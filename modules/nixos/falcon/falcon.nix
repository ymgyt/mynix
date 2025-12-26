{
  stdenv,
  lib,
  dpkg,
  openssl,
  libnl,
  zlib,
  autoPatchelfHook,
  buildFHSEnv,
  debFile,
  version,
  arch,
  ...
}:
let
  pname = "falcon-sensor";

  falcon-sensor = stdenv.mkDerivation {
    inherit version arch;
    name = pname;
    src = debFile;

    buildInputs = [
      dpkg
      zlib
      autoPatchelfHook
    ];

    sourceRoot = ".";

    unpackPhase = ''
      dpkg-deb -x $src .
    '';

    installPhase = ''
      cp -r . $out
    '';

    meta = with lib; {
      description = "Crowdstrike Falcon Sensor";
      homepage = "https://www.crowdstrike.com/";
      license = licenses.unfree;
      platforms = platforms.linux;
    };
  };
in
buildFHSEnv {
  name = "fs-bash";
  targetPkgs = pkgs: [
    libnl
    openssl
    zlib
  ];

  extraInstallCommands = ''
    ln -s ${falcon-sensor}/* $out/
  '';

  runScript = "bash";
}
