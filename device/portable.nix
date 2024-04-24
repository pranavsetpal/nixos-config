{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    "${modulesPath}/installer/scan/not-detected.nix"
  ];

  # boot.kernelPackages = pkgs.linuxPackages-libre;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.availableKernelModules = [ "vmd" "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" "v4l2loopback" ];
  boot.extraModulePackages =  with config.boot.kernelPackages; [];

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-label/BOOTEFI";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS";
    fsType = "xfs";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/HOME";
    fsType = "xfs";
  };

  swapDevices = [
    { device = "/dev/disk/by-label/SWAP"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
