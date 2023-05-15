{ config, lib, pkgs, user, ... }:

{
  environment.systemPackages = with pkgs; [
    waybar
    mpv-unwrapped
  ];

  nixpkgs.overlays = [
    (final: prev: {
      waybar =
        let
          hyprctl = "${pkgs.hyprland}/bin/hyprctl";
          waybarPatchFile = import ./workspace-patch.nix { inherit pkgs hyprctl; };
        in
        prev.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
          postPatch = (oldAttrs.postPatch or "") + ''
            sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp'';
        });
    })
  ];

  home-manager.users.justin = {
    # Home-manager waybar config
    programs.waybar = {
      enable = true;
      systemd = {
        enable = false;
        target = "graphical-session.target";
      };
   # home.file = {
   #   ".config/waybar/config".source = ./config
   #   ".config/waybar/style.css".source = ./style.css
   # };
   };
  };
}
