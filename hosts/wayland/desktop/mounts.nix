{ config, lib, pkgs, modulesPath, ... }:
{
# blkid 
# Will list all the disks by uuid

  fileSystems."/mnt/ssdstorage" = {
    device = "/dev/disk/by-uuid/887C874A7C8731CC";
    fsType = "ntfs3";
    options = [ "nosuid" "nodev" "nofail" "x-gvfs-show"];
  };

# Note: ran the following command to fix an error which preventing mounting
# ntfsfix --clear-dirty /dev/sda1

  fileSystems."/mnt/storage" = {
    device = "/dev/disk/by-uuid/34E2AD0DE2ACD480";
    fsType = "ntfs3";
    options = [ "nosuid" "nodev" "nofail" "x-gvfs-show"];
  };

# The options prevented the system from crashing at boot from a failed drive

  fileSystems."/mnt/windows" =
    { device = "/dev/disk/by-uuid/8644AF8B44AF7C95"; #8644AF8B44AF7C95
      fsType = "ntfs3";
      options = [ "nosuid" "nodev" "nofail" "x-gvfs-show"];
    };

  fileSystems."/mnt/m2storage" = {
    device = "/dev/disk/by-uuid/58BE882EBE88072A";
    fsType = "ntfs3";
    options = [ "nosuid" "nodev" "nofail" "x-gvfs-show"];
  };


  # mount cifs truenas scale need cifs-utils package
    fileSystems."/mnt/alliance" = {
    device = "//192.168.88.156/Alliance/";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  };

}
