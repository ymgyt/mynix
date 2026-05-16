{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lm_sensors
    i2c-tools
  ];
}
