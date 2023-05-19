{config, lib, pkgs, inputs,  ...}:  {
  imports = [
 #   ../eww
    ../waybar
 #   ../mpv
    ../fonts
   # ../nvim
  ];

# nixpkgs.config.allowBroken = true; # PIA app needs this

  programs = {
    dconf.enable = true;
#    light.enable = true; # can't seem to lower brightness with it
  };
  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
    xwayland = {
      enable = true;
      hidpi = false;
    };
  };

#  sound = {
#    enable = true;
#    mediaKeys.enable = true;
#  };

  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # needed?
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
#      inputs.xdg-desktop-portal-hyprland.packages.${pkgs.system}.default
    ];
  };

#  home-manager.users.justin = {
#    home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
#  };

  users.users = {
    justin = {
      packages = with pkgs; [
        # apps specific for Hyprland
        wl-clipboard 
        libgnome-keyring
        gsettings-qt
        amarena-theme # gtk theme amarena

#-------Blue Tooth------#
#        blueman # bluetooth
#        bluez # bluetooth support
#        bluez-alsa # Alsa backend
        brightnessctl
        xdg-desktop-portal-hyprland
        libsForQt5.kdeconnect-kde # features for phone
        wayland-utils # useful?
        way-displays # useful?
        kanshi # display config tool
        openrgb-with-all-plugins # RGB lighting control
        networkmanagerapplet # proper nm tray
        polkit_gnome
        hyprpaper
        eww-wayland
        waybar
        rofi-wayland
        trayer
        mpvpaper
        swaylock-effects
        dunst
      ];
    };
  };
}
