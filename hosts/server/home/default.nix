{ config, pkgs, lib, inputs, ... }:
{
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "23.05";

  imports = [
 #   ./../../../modules/nvim
    "${fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master"}/modules/vscode-server/home.nix"
  ];

  programs.home-manager.enable = true;

  services.vscode-server.enable = true;

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


  home.file = {
#    ".config/dashy/conf.yml".source = ./config/dashy/conf.yml;
  };

  home.packages = with pkgs; [
        #-------Server Software-------#
 #       lf # file manager | ranger replacement
        ffmpeg-headless
	neofetch
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
