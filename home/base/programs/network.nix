{ pkgs, ... }:
{
  home.packages = with pkgs; [
    openssh
    openssl
    dig
    tcpdump
    lsof
    wireshark
  ];
}
