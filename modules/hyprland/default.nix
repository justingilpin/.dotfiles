<<<<<<< HEAD
{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.hyprland;

in {
    options.modules.hyprland= { enable = mkEnableOption "hyprland"; };
    config = mkIf cfg.enable {
	home.packages = with pkgs; [
	    wofi swaybg wlsunset wl-clipboard hyprland
	];

        home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
    };
=======
{
  imports = [
 #   ./events.nix
 #   ./config.nix
 #   ./windowrules.nix # includes layerrules
 #   ./animations.nix
  ];
>>>>>>> 55b7ab876808de6e97fb99da36e72842c136fd73
}
