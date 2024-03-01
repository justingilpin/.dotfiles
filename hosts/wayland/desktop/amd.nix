{ config, lib, pkgs, ... }:
{

  # Enable Vulkan
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };


  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages.clr.icd # OpenCL
    amdvlk
  ];

  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];
  # AMD Kernel
  boot.initrd.kernelModules = [ "amdgpu" ];
  # XServer
  services.xserver.videoDrivers = ["amdgpu"];

  # HIP
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
}

