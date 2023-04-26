{ inputs, pkgs, lib, config, ... }: {

  programs.hyprland.package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

  imports = [

  ];


  programs = {
    # enable hyprland and required options
    hyprland = {
      enable = true;
      nvidiaPatches = true;
#      xwayland.hidpi = true;
    };

    # backlight control
 #   light.enable = true;

 #   steam.enable = true;

#    sway = {
#      enable = true;
  #    package = inputs.self.packages.${pkgs.hostPlatform.system}.sway-hidpi;
    };

    # add hyprland to display manager sessions
  #  xserver.displayManager.sessionPackages = [inputs.hyprland.packages.${pkgs.hostPlatform.system}.default];
  



}
