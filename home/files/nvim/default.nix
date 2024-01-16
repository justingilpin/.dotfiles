{ config, pkgs, ... }:
{
  programs = {
    neovim = {
      enable = true;
      package = pkgs.neovim-unwrapped;
      plugins = with pkgs.vimPlugins; [
        packer-nvim
	nvim-surround
      ];
      extraConfig = ''
        packadd! packer.nvim
      '';
    };
  };
}

