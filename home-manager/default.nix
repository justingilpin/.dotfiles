{ config, pkgs, lib, nixvim, nix-colors,inputs, ... }:
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
  ];

  colorScheme = nix-colors.colorSchemes.gruvbox-dark-hard;

  programs.home-manager.enable = true;
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
#  programs.gpg.enable = true;
#  services.gpg-agent = {
#    enable = true;
#    pinentryFlavor = "gtk2";
#    enableBashIntegration = true;
#    enableZshIntegration = true;
#    enableSshSupport = true;
#    defaultCacheTtl = 86400;
#    defaultCacheTtlSsh = 86400;
#  };
#  programs.keychain = {
#    enable = true;
#    keys = [
#        "id_ed25519"
#    ];
#  };



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
        "*.dpi" = 120;
      };
    };
}
