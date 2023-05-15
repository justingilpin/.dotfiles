{ config, lib, pkgs, ... }:
{
  imports = [
  #  ./luajit.nix
  ];
  users.users = {
    justin = {
      packages = with pkgs; [ 

        # apps specific for AwesomeWM
        dmenu
        pamixer
        alsa-utils
        mpc-cli
        mpd
        scrot
        unclutter
        xorg.xbacklight
        xsel
        slock
        libsForQt5.qt5.qtgraphicaleffects
        picom-jonaburg
        dunst
        feh
  	networkmanagerapplet
  	xfce.thunar
  	xfce.thunar-volman
  	xfce.thunar-dropbox-plugin
  	xfce.thunar-archive-plugin
        xfce.thunar-media-tags-plugin
  	gvfs
  	polkit_gnome
  	ranger
  	rofi
  	libnotify
  	xfce.xfce4-terminal
  	libcanberra-gtk3
  	brightnessctl
  	nitrogen
  	autorandr
  	arandr
  	neofetch
  	## wifi
  	iwgtk
  	keychain
  	libsForQt5.kwallet
  	# audio
  	pulseaudio
      ];
    };  
  };
  # Enables x11 and keymap
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";

  # Enables Display Manager
    displayManager = {
        sddm.enable = true;
        defaultSession = "none+awesome";
    };
  # Enables Awesome Windows Manager
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # is the package manager for Lua modules
        luadbi-mysql # Database abstraction layer
      ];
    };
  # Enables x11 Trackpad
    libinput = {
      enable = true;
      touchpad = {
        disableWhileTyping = true;
        naturalScrolling = true;
      };
    };
  };
}
