{ config, lib, pkgs, ... }:

let
  # Check for NVIDIA GPU at common PCI slot
  nvidiaDevicePath = "/sys/bus/pci/devices/0000:01:00.0";
  hasNvidia = builtins.pathExists "${nvidiaDevicePath}/vendor"
    && builtins.pathExists "${nvidiaDevicePath}/device";
in
{
  config = lib.mkIf hasNvidia {
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
