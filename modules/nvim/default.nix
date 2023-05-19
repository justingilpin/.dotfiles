{ config, pkgs, ... }:
{
  programs = {
    neovim = {
      enable = true;
      package = pkgs.neovim-unwrapped;
      plugins = with pkgs.vimPlugins; [
    #    packer-nvim
      ];
      extraConfig = ''
    #    packadd! packer.nvim
    #    luafile ${./lua/util.lua}
    #    luafile ${./lua/plugins.lua}
    #    luafile ${./lua/options.lua}
    #    luafile ${./lua/keys.lua}
      '';
    };
  };
}

