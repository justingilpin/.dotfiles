{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      packer-nvim
    ];
    extraConfig = ''
      packadd! packer.nvim
      luafile ${./files/nvim/lua/util.lua}
      luafile ${./files/nvim/lua/plugins.lua}
      luafile ${./files/nvim/lua/options.lua}
      luafile ${./files/nvim/lua/keys.lua}
    '';
  };

  environment.systemPackages = with pkgs; [
    # nix
    rnix-lsp

    # rust
    rustfmt

    # lua
    efm-langserver
    luaformatter
    sumneko-lua-language-server

    nodejs_latest
  ];
}
