{ config, pkgs, ... }:

{
  hardware.opengl.driSupport32Bit = true;
  environment.systemPackages = with pkgs; [
    glxinfo
    mesa
    wineWowPackages.staging
  ];
}
