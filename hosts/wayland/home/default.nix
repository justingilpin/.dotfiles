{ config, pkgs, lib, nixvim, nix-colors, inputs, ... }:
{
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "23.05";

  imports = [
   ./../../../modules/nvim
  ];


  programs.home-manager.enable = true;

#  home.file."~/.config/hypr/hyprland.conf".source = ~/.dotfiles/home/files/hyprland.conf;
#  home.file."~/.config/hypr/hyprpaper.conf".source = ~/.dotfiles/home/files/hyprpaper.conf;

  programs.zsh = { 
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      initExtra = builtins.readFile ./../../../home/files/zshrc;
      initExtraBeforeCompInit = ''
        source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.zsh
      '';
      oh-my-zsh = {
        enable = true;
     #   theme = "robbyrussell";
        plugins = [ "python" ];
      };
    }; 

  programs.vscode = {
  enable = true;
  extensions = with pkgs.vscode-extensions; [
    dracula-theme.theme-dracula
    vscodevim.vim
    yzhang.markdown-all-in-one
  ];
};

  home.packages = with pkgs; [
#     texlive.combined.scheme-full
#        auctex
#        zlib
        (python39.withPackages(p: with p; [
          fontforge
          numpy
	  pyquery
#	  jupyter
#	  ipykernel
#	  matplotlib
#	  tensorflow
          pandas
          flask
          virtualenvwrapper
          pip
          httpx
          pygobject3
        ]))
          # Wine + winetricks
#          wineWowPackages.waylandFull
#          winetricks
          # Vulkan
#          vulkan-cts
#          vulkan-tools


        #-------Favorite Software-------#
 #       gimp-with-plugins
 #       deluge-gtk
        lf # file manager | ranger replacement
 #       gperftools # TCMalloc for development 
        neofetch
 #       mpd-small
        #discord
 #       pulseaudio
 #       pavucontrol
 #       openvpn
 #       xfce.thunar # file manager
 #       sioyek # pdf viewer
        libreoffice-still
        obsidian
        vlc
        lutris
	vivaldi
	tor
	tor-browser
	ffmpeg-headless # codex for video streaming

        # Wayland Tools
	wofi
	hyprpaper
	webcord # discord replacement
	grim # Capture images with wayland
	slurp # Select a region in wayland compositor pairs with grim
	gamemode
	networkmanagerapplet
	waybar
	dunst
	pavucontrol
	wlogout

#        restic
        #------------ZSH----------------#
        starship
        zsh-syntax-highlighting
        zsh-vi-mode


      #-----------Security------------#
 #       gnupg
 #       sops
 #       age

    ];
    
}
