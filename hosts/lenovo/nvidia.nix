{ config, lib, pkgs, ... }:
{


  ###    NVIDIA SETUP for Lenovo Laptop Y740 2080   ###
  # Optionally, you may need to select the appropriate driver version for your specific GPU 
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.prime.nvidiaBusId = "PCI:1:0:0"; # check with lspci cmd
  hardware.nvidia.prime.intelBusId = "PCI:0:2:0";

  # Needed for some wayland compositors, e.g. sway
  hardware.nvidia.modesetting.enable = true;
  # hardware.nvidia.prime.sync.enable = true; # turns Nvidia always on
  hardware.nvidia.prime.offload.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.nvidia.powerManagement.enable = true;
  services.xserver.videoDrivers = ["nvidia"]; # Wiki says it will work with Wayland despite it's name

}
