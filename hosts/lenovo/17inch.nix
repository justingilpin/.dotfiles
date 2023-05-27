{ lib, ... }:

{
  imports = [
    ./../common/cpu/intel
    ./../common/gpu/nvidia/prime.nix
    ./../common/pc/laptop
    ./../common/pc/laptop/ssd
    ./../common/pc/laptop/hdd
  ];

# Justin's addon
#  services.xserver.videoDrivers = ["nvidia"];
#  hardware.opengl.enable = true;
#  hardware.nvidia.modesetting.enable = true;
#  hardware.nvidia.optimus_prime = {
#    enable = true;
#    nvidiaBusId = "PCI:1:0:0";
#    intelBusId = "PCI:0:2:0";
#  };


  hardware = {
    opengl.driSupport32Bit = true;
    nvidia = {
      modesetting.enable = lib.mkDefault true;
      powerManagement.enable = lib.mkDefault true; 
      prime = {
        # Force Nvidia Always-ON + have to comment out prime.nix above
        # sync.enable = true;
        # End Force Always-ON
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  services.thermald.enable = lib.mkDefault true;
}
