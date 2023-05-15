{ config, lib, pkgs, ...}:
{
    imports = [
        ./qtile.nix # enables qtile
        ../fonts
    #    ./users.nix
    #    ./security_gpg.nix
    #    ./flakes.nix
    #    ./networking_i18n.nix
    #    ./devel.nix
    #    ../overlays
    ];


   # system.stateVersion = "22.05";

    environment.systemPackages =
        let
       #     sddmClairvoyance = pkgs.callPackage ../packages/sddmThemes/clairvoyance.nix {};
       #     sddmSD = pkgs.callPackage ../packages/sddmThemes/sugarDark.nix {};
        in with pkgs; [
       #     sddmClairvoyance
       #     sddmSD.sddm-sugar-dark
            libsForQt5.qt5.qtgraphicaleffects
            picom-jonaburg
       #     python310Packages.qtile-extras # no effect?
       #     qtile-unwrapped
            dunst
            feh
            networkmanagerapplet
            wget
            alacritty
            nano
            git
            git-crypt
            emacs
            firefox
                
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
            # audio
            pulseaudio

            # Openbox
            obconf
            openbox-menu
            libadwaita
            gtk2
            gtk3

            ## Wayland
            wayland
            wayland-utils
            wdisplays
            wlr-randr
            
            libcanberra-gtk3
            brightnessctl
            nitrogen
            feh
            autorandr
            arandr
            ## wifi
            iwgtk
            keychain
            libsForQt5.kwallet


            gparted
            ## libby requirements
            jq
            pup
            recode
            fzf

            rofi-rbw
            nix-prefetch-git
            discord

            neofetch
        ];

}
