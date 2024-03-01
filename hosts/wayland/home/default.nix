{ config, pkgs, lib, nixvim, nix-colors, inputs, ... }:
{
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "23.05";

  imports = [
    #./gtk
    #./desktop
    #./devel
    #./media
    #nix-colors.homeManagerModule
   ./../../../modules/nvim
#   ./../modules/plasma
#  ./../modules/nvim-ide
  ];

  # colorScheme = nix-colors.colorSchemes.gruvbox-dark-hard;

  programs.home-manager.enable = true;
  home.file.".background-image".source = ./../../../home/images/oceansbg.jpg;

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

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind =
      [
        "$mod, F, exec, firefox"
        ", Print, exec, grimblast copy area"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
  };



  home.packages = with pkgs; [
#     texlive.combined.scheme-full
#        auctex
#        zlib
        (python39.withPackages(p: with p; [
          fontforge
          numpy
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
        discord
 #       pulseaudio
 #       pavucontrol
 #       openvpn
 #       xfce.thunar # file manager
 #       sioyek # pdf viewer
        libreoffice-still
        obsidian
        vlc
        lutris
        feh
	vivaldi
	tor
	tor-browser
	ffmpeg-headless # codex for video streaming

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
