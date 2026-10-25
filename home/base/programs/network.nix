{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dig
    inetutils
    lsof
    openssh
    openssl
    tcpdump
    wireshark
  ];
}
