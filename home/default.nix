{ config, pkgs, lib, nixvim, nix-colors, inputs, ... }:
{
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "23.05";
  imports = [
   ./../modules/nvim
  ];


  programs.home-manager.enable = true;

#  home.file."~/.config/hypr/hyprland.config".source = ~/.dotfiles/home/files/hyprland.config;
#  home.file."~/.config/hypr/hyprpaper.config".source = ~/.dotfiles/home/files/hyprpaper.conig;

  programs.zsh = { 
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      initExtra = builtins.readFile ./files/zshrc;
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


        #-------Favorite Software-------#
 #       gimp-with-plugins
        lf # file manager | ranger replacement
        neofetch
        discord
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
	gamemode


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
