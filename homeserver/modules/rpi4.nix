# Common settings for Raspberry Pi4 Model B
{ pkgs, user, ... }: {

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  time.timeZone = "Asia/Tokyo";

  environment.systemPackages = with pkgs; [
    helix
    git
    bottom
    bat
    lsof
    # cgroup tools
    libcgroup
  ];

  services.openssh.enable = true;

  users = {
    mutableUsers = false;
    users."${user}" = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB8gnwsBvzfnFArlA8+tWWCJ64MjvzwoiTidWEgT3Mbf ymgyt"
      ];
    };
  };
  security.sudo.wheelNeedsPassword = false;

  # needed when deploy-rs remoteBuild = false
  # https://github.com/NixOS/nix/issues/2450
  nix.settings.trusted-users = [ "${user}" ];

  # garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
    persistent = true;
    randomizedDelaySec = "30sec";
  };

  # not applyied yet for incrementalism
  # boot.loader.systemd-boot.configurationLimit = 10;
  # nix.settings.auto-optimise-store = true;

  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "23.11";
}
