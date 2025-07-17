{ config, pkgs, ... }: {

  # enable virtual
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.runAsRoot = false;
  # virtualisation.qemu.swtpm.enable = true;
  virtualisation.vmware.host.enable = true;
  virtualisation.vmware.guest.enable = true;
  programs.virt-manager.enable = true;

  #virt network
  # virtualisation.libvirtd.qemu.networks.default.enable = true;
}
