{ config, pkgs, lib, nixvim, nix-colors, inputs, ... }:
{
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "22.11";

  imports = [
   # ./gtk
   # ./desktop
   # ./devel
   # ./media
    nix-colors.homeManagerModule
   ./../modules/nvim
  ];

  colorScheme = nix-colors.colorSchemes.gruvbox-dark-hard;

  programs.home-manager.enable = true;
  programs.vscode = {
  enable = true;
  extensions = with pkgs.vscode-extensions; [
    dracula-theme.theme-dracula
    vscodevim.vim
    yzhang.markdown-all-in-one
  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "remote-ssh-edit";
      publisher = "ms-vscode-remote";
      version = "0.47.2";
      sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
    }
  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "signageos-vscode-sops-beta";
      publisher = "signageos";
      version = "0.7.0";
      sha256 = "w7v4rAd9LN1Hd2WIF4W1TcHPUcxsoIiHCYe4QNIjHvw=";
    }
  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "joplin-vscode-plugin";
      publisher = "rxliuli";
      version = "1.1.1";
      sha256 = "77U9xu3MNw1Ao6MXOYiqemr/9hevMN7Wm70Tur9HRP4=";
    }
  ];
  };
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
    #    theme = "robbyrussell";
        plugins = [ "python" ];
      };
    }; 
  #programs.neovim = {
  #  enable = true;
  #  package = pkgs.neovim-unwrapped;
  #  plugins = with pkgs.vimPlugins; [
  #    # nvim-surround
  #     packer-nvim
  #  ];
  #  extraConfig = ''
  #    packadd! packer.nvim
  #    luafile ${./files/nvim/lua/util.lua}
  #    luafile ${./files/nvim/lua/plugins.lua}
  #    luafile ${./files/nvim/lua/options.lua}
  #    luafile ${./files/nvim/lua/keys.lua}
  #  '';
  #};
  #home.file.".config/nvim/settings.lua".source = ./files/nvim/lua/init.lua;
  home.packages = with pkgs; [
     texlive.combined.scheme-full
        auctex
        zlib
        (python39.withPackages(p: with p; [
          fontforge
          numpy
          pandas
          flask
          virtualenvwrapper
          pip
          httpx
          pygobject3
        ]))
        #-------Favorite Software-------#
        gimp-with-plugins
        deluge-gtk
        lf # ranger replacement
        kitty
        neofetch
        mpd-small
        discord
        pulseaudio
        pavucontrol
        openvpn
        sioyek # pdf viewer
        #------------ZSH----------------#
        starship
        zsh-syntax-highlighting
        zsh-vi-mode


      #-----------Security------------#
        gnupg
        sops
        age

        nodePackages.pyright
        nodejs
        nodePackages.npm
        nodePackages.tailwindcss
        nodePackages.postcss-cli
        nodePackages.typescript
        nodePackages.degit
        nodePackages.postcss
        rustc
        cargo
        go
        thefuck
        jq
        pup
        #libby
        gcc
        binutils
        (ripgrep.override { withPCRE2 = true; })
        gnutls
        fd
        imagemagick
        zstd
        nodePackages.javascript-typescript-langserver
        sqlite
        editorconfig-core-c
        emacs-all-the-icons-fonts
        hugo
        nix-prefetch-git
    ];
    
    nixpkgs.overlays = [
      (
        self: super: {
   #       libby = super.callPackage ../packages/libby/default.nix {};
        }
      ) 
    ];



    xresources = {
      extraConfig = ''
        ! ${config.colorScheme.slug} !
        #define bg #${config.colorScheme.colors.base00}
        #define bgBright #${config.colorScheme.colors.base02}
        #define fg #${config.colorScheme.colors.base06}
        #define red #${config.colorScheme.colors.base08}
        #define orange #${config.colorScheme.colors.base09}
        #define yellow #${config.colorScheme.colors.base0A}
        #define green #${config.colorScheme.colors.base0B}
        #define teal #${config.colorScheme.colors.base0C}
        #define blue #${config.colorScheme.colors.base0D}
        #define purple #${config.colorScheme.colors.base0E}
        #define brown #${config.colorScheme.colors.base0F}
      '';
      properties = {
        "*.background" = "bg";
        "*.foreground" = "fg";
        "*.dpi" = 100; # default 120
      };
    };
}
