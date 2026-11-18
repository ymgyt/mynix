{
  lib,
  stdenvNoCC,
  requireFile,
  dpkg,
  buildFHSEnv,
  libnl,
  openssl,
  zlib,
}:
let
  pname = "falcon-sensor";
  version = "8.11.0-19508";
  debName = "${pname}_${version}_amd64.deb";

  meta = {
    description = "CrowdStrike Falcon Sensor";
    homepage = "https://www.crowdstrike.com/";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };

  # The files of the deb, unmodified.
  unwrapped = stdenvNoCC.mkDerivation {
    pname = "${pname}-unwrapped";
    inherit version meta;

    # The deb is proprietary and has no public URL, so Nix cannot fetch it.
    src = requireFile {
      name = debName;
      hash = "sha256-7+XcZDw9wpLix9/UaYMV8Jjp12WE+jrIMCmMAgJQrvw=";
      message = ''
        Download ${debName} and add it to the Nix store:

          nix-store --add-fixed sha256 ${debName}
      '';
    };

    nativeBuildInputs = [ dpkg ];

    unpackPhase = ''
      dpkg-deb -x $src .
    '';

    installPhase = ''
      mkdir $out
      cp -r etc lib opt $out
    '';

    # The binaries run only inside the FHS environment, so they stay as shipped.
    dontFixup = true;
  };
in
# The sensor loads libssl and libnl with dlopen and reads fixed paths such as
# /bin/bash, which patching the ELF files cannot satisfy.
buildFHSEnv {
  inherit pname version meta;
  executableName = "fs-bash";

  targetPkgs = _: [
    libnl
    openssl
    zlib
  ];

  runScript = "bash";

  passthru = { inherit unwrapped; };
}
