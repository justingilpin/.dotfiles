{ config, lib, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    layout = "us"; ## configure keymap
    xkbOptions = ""; 
    libinput.enable = true;  # Enable touchpad support (enabled default in most desktopManager).
    displayManager = {
      defaultSession = "none+qtile"; 
      sddm = {
        enable = true;
        # theme = "clairvoyance";
       # theme = "sugar-dark";
      };
    };
    windowManager = {
       qtile = {
         enable = true;
         extraPackages = python3Packages: with python3Packages; [
           qtile-extras
        ];
      };
    #  openbox.enable = true;
    #  qtile.backend = "wayland"; # "x11" or "wayland"
    };
  };

  services.printing.enable = true;
  programs.sway.enable = true;
  programs.dconf.enable = true;
  
#  nixpkgs.overlays = [(
#    self: super: {
#      qtile = super.qtile.unwrapped.override (old: rec {
#        src = super.fetchFromGitHub {
#          owner = "qtile";
#          repo = "qtile";
#          rev = ''b3dba207204df290fc32d14a270918695b50e154'';  # qtile
#          sha256 = ''0227r1r1y8lrqd146w9wn0c1mslkkr2pxbabhs0qip3dslxqwppl'';  # qtile
#        };
#        qtile-extras = super.pkgs.python3Packages.buildPythonPackage {
#          pname = "qtile-extras";
#          version = "0.1.0";
#          src = super.fetchgit {
#            url = "https://github.com/elparaguayo/qtile-extras";
#            rev = ''da6ce83b843d9e55501107cc1fde4a65b6f3d475'';  # extras
#            sha256 = ''1h56kb4kqy7080h9da499nc5hr74zw1hxp6n2digzrzhswjmwmid'';  # extras
#            leaveDotGit = true;
#          };
#          doCheck = false;  # do not run tests because it can't find libqtile anyway
#          nativeBuildInputs = with super.pkgs; [ git ];
#          buildInputs = with super.pkgs.python3Packages; [ setuptools_scm ]; # old with pkgs
#          meta = with super.lib; {
#            homepage = "https://github.com/elParaguayo/qtile-extras";
#            license = licenses.mit;
#            description = "Extras for Qtile";
#            platforms = platforms.linux;
#          };
#        };
#        propagatedBuildInputs = (old.propagatedBuildInputs or [ ]) ++ (with super.pkgs; [ # old with pkgs
#          libinput
#          libxkbcommon
#          pulseaudio
#          wayland
#          wlroots
#          qtile-extras
#        ]) ++ (with super.pkgs.python3Packages; [ # old pkgs.python3Packages
#          dbus-next
#        ]);
#      });
#    })];

}
