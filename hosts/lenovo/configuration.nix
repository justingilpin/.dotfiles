{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # Import your generated (nixos-generate-config) hardware configuration
    # NixOS profiles to optimize settings for different hardware
    # https://github.com/NixOS/nixos-hardware
    ./hardware-configuration.nix
    ./17inch.nix
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

  # Set your time zone.
  time.timeZone = "Asia/Manila";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
#     LC_ADDRESS = "en_US.UTF-8"; 
    LC_ADDRESS = "fil_PH";
    LC_IDENTIFICATION = "fil_PH";
    LC_MEASUREMENT = "fil_PH";
    LC_MONETARY = "fil_PH";
    LC_NAME = "fil_PH";
    LC_NUMERIC = "fil_PH";
    LC_PAPER = "fil_PH";
    LC_TELEPHONE = "fil_PH";
    LC_TIME = "fil_PH";
  };  

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
#    wireplumber.enable = true;
#    jack.enable = true;
  };

  # Enable Tailscale
  services.tailscale.enable = true;


  # Shell

  programs.zsh.enable = true; # configured in /modules/shell
  environment.shells = with pkgs; [ zsh ]; # Many programs look if user is a 'normal' user 
  environment.binsh = "${pkgs.dash}/bin/dash";
 
  # Set your hostname
  networking.hostName = "fibonacci";

  # Enable Networking
  networking.networkmanager.enable = true;
  
  # Firewall
  networking.firewall.enable = false;

  # Enable Polkit to manage passwords
#  security.polkit.enable = true;

  # This is just an example, be sure to use whatever bootloader you prefer
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.kernelPackages = pkgs.linuxPackages_latest;
  services.logind.extraConfig = "RuntimeDirectorySize=6G";
#  environment.systemPackages = [
#    pkgs.meslo-lgs-nf
#    pkgs.zsh-autosuggestions
#  ];
  # Enable NTFS and mount Internal Storage
  boot.supportedFilesystems = [ "ntfs" ];
    fileSystems."/mnt/storage" = 
    { device = "/dev/disk/by-uuid/34E2AD0DE2ACD480";
      fsType = "ntfs3";
      options = [ "rw" "uid=1000" "gid=1000" "dmask=027" "fmask=137" "user" "users" "noauto" "x-systemd.automount" "nofail"];
    };
  # Install System Wide Packages
  environment.systemPackages = with pkgs; [
    kitty
    git
    git-crypt
    wget
    tailscale
  ];
  #  User Conigured Packages
  users.users = {
    # FIXME: Replace with your username
    justin = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "password";
      isNormalUser = true;
      description = "justin";
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ "audio" "networkmanager" "wheel" ];
      packages = with pkgs; [
        firefox
        nano
 #       polkit_gnome
        lutris
        brave
        kate
        alacritty
        emacs
        home-manager
        nm-tray # does it work? Qtile specific?
        joplin-desktop
        zoom-us
        wofi
        # Everdo Appimage
        (appimageTools.wrapType2 {
          name = "everdo";
          src = fetchurl {
            url = "https://release.everdo.net/1.8.5/Everdo-1.8.5.AppImage";
            sha256 = "sha256-/DZ6CCJOS/lm5hzBailLOtrUDRyOEzVBDKwYmlFpsU8=";
          };
          extraPkgs = pkgs: with pkgs; [ ];
        })
 
      ];
    };
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
#  services.openssh = {
#    enable = true;
    # Forbid root login through SSH.
#    permitRootLogin = "no";
    # Use keys only. Remove if you want to SSH using password (not recommended)
#    passwordAuthentication = false;
#  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05"; #22.11
}
