# Justin's Hyprland Desktop Config

{ config, lib, pkgs, ... }:

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

  # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
  ];

  # A fix for warp-terminal. Waiting for official package
  nixpkgs.config.allowUnsupportedSystem = true;

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

  networking.hostName = "donchian"; # Define your hostname.
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

  # Enable Hyprland edit config in home manager
  programs.hyprland.enable = true;

  # Enable Tailscale
  services.tailscale.enable = true;

  # Shell
  programs.zsh.enable = true; # configured in /modules/shell
  environment.shells = with pkgs; [ zsh ]; # Many programs look if user is a 'normal' user
  environment.binsh = "${pkgs.dash}/bin/dash";
  users.defaultUserShell = pkgs.zsh;
  # Also check that user has shell enabled

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

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
