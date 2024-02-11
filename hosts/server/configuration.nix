# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#      ./dashy.nix
    ];
  
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
      warn-dirty = false; # remove git warnings
    };
  };


  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "jim_simons"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

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

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  
  # Enable Tailscale
  services.tailscale.enable = true;

  # Shell
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  environment.binsh = "${pkgs.dash}/bin/dash";
  users.defaultUserShell = pkgs.zsh;
  # Also check that user has shell enabled


  # Enable Docker Containers
  virtualisation.docker.enable = true;
  # Docker Containers - Create /data/docker folder
#  systemd.tmpfiles.rules = [
#    "d /data/docker 0750 root root -"
#  ];

#  virtualisation.oci-containers.backend = "docker";
#  virtualisation.docker = {
#    enable = true;
#    enableOnBoot = true;
   # storageDriver = "zfs";

#    rootless = {
#      enable = false;
      # setSocketVariable = true;
#    };

#    daemon.settings = {
#      experimental = true;
#    };
#  };


  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.justin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    #  firefox
    #  tree
    ];
    shell = pkgs.zsh;
    useDefaultShell = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    lemonade
    wget
    git
    git-crypt
    tailscale
    cifs-utils 
    docker-compose
    docker
    sysstat
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
#  programs.gnupg.agent = {
#    enable = true;
#    enableSSHSupport = true;
#  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

#  environment.etc."nextcloud-admin-pass".text = "test123";
#  services.nextcloud = {                
#    enable = true;                   
#    package = pkgs.nextcloud28;
    # Instead of using pkgs.nextcloud28Packages.apps,
    # we'll reference the package version specified above
#    hostName = "nextcloud.tld";
   # database.createLocally = true;
#    config = {
#      dbtype = "pgsql";
#      adminpassFile = "/etc/nextcloud-admin-pass";
#    };
   # extraApps = {
   #   inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
   # };
   # extraAppsEnable = true;
#  };

  # Open ports in the firewall.
#  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  # networking.firewall.trustedInterfaces = [ "docker0" ];
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
  system.stateVersion = "23.11"; # Did you read the comment?

}

