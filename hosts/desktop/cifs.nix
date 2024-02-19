{ config, lib, pkgs, modulesPath, ... }:
{
# blkid 
# Will list all the disks by uuid
  fileSystems."/mnt/ssdstorage" =
    { device = "/dev/disk/by-uuid/887C874A7C8731CC"; #887C874A7C8731CC
      fsType = "ntfs3";
    };

  fileSystems."/mnt/storage" =
    { device = "/dev/disk/by-uuid/34E2AD0DE2ACD480"; # 34E2AD0DE2ACD480
      fsType = "ntfs3";
    };

  fileSystems."/mnt/windows" =
    { device = "/dev/disk/by-uuid/8644AF8B44AF7C95"; #8644AF8B44AF7C95
      fsType = "ntfs3";
    };

  fileSystems."/mnt/m2storage" =
    { device = "/dev/disk/by-uuid/58BE882EBE88072A"; # 58BE882EBE88072A      
      fsType = "ntfs3";
    };

}
