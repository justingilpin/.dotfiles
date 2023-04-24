{ config, lib, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    layout = "us"; ## configure keymap
    xkbOptions = ""; # map caps to escape
    libinput.enable = true;  # Enable touchpad support (enabled default in most desktopManager).
    desktopManager.plasma5.enable = true;
    displayManager = {
      defaultSession = "plasma"; 
      sddm = {
        enable = true;
        # theme = "clairvoyance";
        theme = "sugar-dark";
      };
    };
  };
}
