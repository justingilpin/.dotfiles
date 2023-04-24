{ config, lib, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    layout = "us"; ## configure keymap
    xkbOptions = ""; # map caps to escape
    libinput.enable = true;  # Enable touchpad support (enabled default in most desktopManager).
    displayManager = {
      defaultSession = "none+qtile"; 
      sddm = {
        enable = true;
        # theme = "clairvoyance";
        theme = "sugar-dark";
      };
    };
    windowManager = {
      qtile.enable = true;
      openbox.enable = true;
    };
  };

  services.printing.enable = true;
  programs.sway.enable = true;
  programs.dconf.enable = true;
  
  nixpkgs.overlays = [(
    self: super: {
      qtile = super.qtile.unwrapped.override (old: rec {
        src = super.fetchFromGitHub {
          owner = "qtile";
          repo = "qtile";
          rev = ''0de37b01b41610efcf41dbad93b6a78ffc20a751'';  # qtile
          sha256 = ''0p6xppr1prhp6psz617f5dw68xvbrbb7dir452bl2m8f1idp9qdq'';  # qtile
        };
        qtile-extras = pkgs.python3Packages.buildPythonPackage {
          pname = "qtile-extras";
          version = "0.1.0";
          src = super.fetchgit {
            url = "https://github.com/elparaguayo/qtile-extras";
            rev = ''da6ce83b843d9e55501107cc1fde4a65b6f3d475'';  # extras
            sha256 = ''1h56kb4kqy7080h9da499nc5hr74zw1hxp6n2digzrzhswjmwmid'';  # extras
            leaveDotGit = true;
          };
          doCheck = false;  # do not run tests because it can't find libqtile anyway
          nativeBuildInputs = with pkgs; [ git ];
          buildInputs = with pkgs.python3Packages; [ setuptools_scm ];
          meta = with super.lib; {
            homepage = "https://github.com/elParaguayo/qtile-extras";
            license = licenses.mit;
            description = "Extras for Qtile";
            platforms = platforms.linux;
          };
        };
        propagatedBuildInputs = (old.propagatedBuildInputs or []) ++ (with pkgs; [
          libinput
          libxkbcommon
          pulseaudio
          wayland
          wlroots
          qtile-extras
        ]) ++ (with pkgs.python3Packages; [
          dbus-next
        ]);
      });
    })];

}
