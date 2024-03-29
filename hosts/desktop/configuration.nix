# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

#let 
#  unstable = import <unstable> {};
#in 

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#      ./nvidia.nix
      ./amd.nix
      ./mounts.nix
    ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Quick fix for Obsidian to allow insecure install
    nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # A fix for warp-terminal. Waiting for official package
#  nixpkgs.config.allowUnsupportedSystem = true;

  nix = {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
      warn-dirty = false; # remove git warnings
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ]; # allows NTFS support at boot

  networking.hostName = "seykota"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # NTP Daemon for clock
  # services.ntp.enable = true;

  # Fixes desktop error when rebuilding Nixos
  systemd.services.NetworkManager-wait-online.enable = false; 
  
  # Set your time zone.
  #time.timeZone = "Etc/GMT+0"; # Temperary fix to get correct time
  time.timeZone = "Asia/Manila";
  #time.timeZone = "America/New_York";
  #time.hardwareClockInLocalTime = true;
  # services.localtimed.enable = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable Tailscale
  services.tailscale.enable = true;

  # Shell
  programs.zsh.enable = true; # configured in /modules/shell
  environment.shells = with pkgs; [ zsh ]; # Many programs look if user is a 'normal' user
  environment.binsh = "${pkgs.dash}/bin/dash";
  users.defaultUserShell = pkgs.zsh;
  # Also check that user has shell enabled

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.enable = true; # X11
  services.xserver.displayManager.sddm.enable = true;
#  services.xserver.displayManager.sddm.wayland.enable = true; # Enable Wayland commit out for X11
  services.xserver.desktopManager.plasma6.enable = true;
#  services.xserver.displayManager.defaultSession ="plasma"; # Enable Wayland 'plasmawayland'
#  services.xserver.desktopManager.wallpaper.mode = "fill";

  # Enable Plasma 6
#  services.xserver.enable = true;
#  services.xserver.displayManager.sddm.enable = true;
#  services.xserver.desktopManager.plasma6.enable = true;
#  services.xserver.displayManager.defaultSession = "plasma"; #'plasmax11' for X11 default plasma

#  environment.plasma6.excludePackages = with pkgs.kdePackages; [
#    plasma-browser-integration
#    konsole
#    oxygen
#  ];


  # Enable Sunshine at Boot
#  security.wrappers.sunshine = {
#    owner = "root";
#    group = "root";
#    capabilities = "cap_sys_admin+p";
#    source = "${pkgs.sunshine}/bin/sunshine";
#  };

#  systemd.user.services.sunshine =
#    {
#      description = "sunshine";
#      wantedBy = [ "graphical-session.target" ];
#      serviceConfig = {
#      ExecStart = "${config.security.wrapperDir}/sunshine";
#    };
#  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Enable OpenRGB
  services.hardware.openrgb.enable = true;
  services.hardware.openrgb.motherboard = "amd";

  # mount cifs truenas scale need cifs-utils package
#    fileSystems."/mnt/alliance" = {
#    device = "//192.168.88.156/Alliance/";
#    fsType = "cifs";
#    options = let
      # this line prevents hanging on network split
#      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

#    in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
#  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.justin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      zoom-us
      tailscale
      steam
      obsidian
      heroic
      prismlauncher
      xsel
      xclip
      dig
      go
#      sunshine
      ffmpeg #encoder
      mesa
      ntfs3g
#      unstable.hello

      # Wayland
#      wlroots
#      wlrctl
#      vaapiVdpau #encoder
      vaapi-intel-hybrid #encoder
#      nv-codec-headers-12 # encoder
      x265 # encoder
#      blender-hip # 3D Creation using HIP enabled in AMD.nix
#      clinfo # OpenCL info
#      gpu-viewer
 #     warp-terminal
    ];
   shell = pkgs.zsh;
   useDefaultShell =true;
    openssh.authorizedKeys.keys = [
    # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
  ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    git-crypt
    alacritty
    kitty
    firefox
    gnome.gnome-disk-utility # used for auto mounting
    cifs-utils # needed for mounting samba shares
  ];


  # mount cifs truenas scale need cifs-utils package
#    fileSystems."/mnt/alliance" = {
#    device = "//192.168.88.156/Alliance/";
#    fsType = "cifs";
#    options = let
      # this line prevents hanging on network split
#      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

#    in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
#  };

#  (appimageTools.wrapType2 {
#    name = "warp";
#    src = fetchurl {
#      url = "";
#      sha256 = "sha256-/DZ6CCJOS/lm5hzBailLOtrUDRyOEzVBDKwYmlFpsU8=";
#    };
#    extraPkgs = pkgs: with pkgs; [ ];
#  })

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11"; # Did you read the comment?

}
