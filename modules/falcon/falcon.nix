{
  stdenv,
  lib,
  dpkg,
  openssl,
  libnl,
  zlib,
  autoPatchelfHook,
  buildFHSUserEnv,
  ...
}:
let
  pname = "falcon-sensor";
  version = "7.05.0-16004";
  arch = "amd64";
  src = /opt/CrowdStrike + "/falcon-sensor_${version}_${arch}.deb";
  falcon-sensor = stdenv.mkDerivation {
    inherit version arch src;
    name = pname;

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
      # maintainers = with maintainers; [  ];
    };
  };
in
buildFHSUserEnv {
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
