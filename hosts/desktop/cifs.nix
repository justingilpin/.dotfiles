{ config, lib, pkgs, modulesPath, ... }:
{

  fileSystems."/mnt/ssdstorage" =
    { device = "/dev/disk/by-uuid/887C874A7C8731CC";
      fsType = "ntfs3";
    };

  fileSystems."/mnt/storage" =
    { device = "/dev/disk/by-uuid/34E2AD0DE2ACD480";
      fsType = "ntfs3";
    };

  fileSystems."/mnt/windows" =
    { device = "/dev/disk/by-uuid/8644AF8B44AF7C95";
      fsType = "ntfs3";
    };

  fileSystems."/mnt/m2storage" =
    { device = "/dev/disk/by-uuid/027E11627E115031";
      fsType = "ntfs3";
    };

}
