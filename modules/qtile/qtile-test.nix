{ config, lib, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    layout = "us"; ## configure keymap
    xkbOptions = ""; 
    libinput.enable = true;  # Enable touchpad support (enabled default in most desktopManager).
    displayManager = {
      defaultSession = "none+qtile"; 
      sddm = {
        enable = true;
        # theme = "clairvoyance";
       # theme = "sugar-dark";
      };
    };
    windowManager = {
      qtile.enable = true;
    #  openbox.enable = true;
      qtile.backend = "x11"; # "x11" or "wayland"
      qtile.extraPackages = python3Packages: with python3Packages; [
        qtile-extras
        psutil
        dbus-python
        pyxdg
        keyring
        mpd2
        dateutil
      ];
    };
  };

  services.printing.enable = true;
  programs.sway.enable = true;
  programs.dconf.enable = true;

}
