{ config, pkgs, ... }: {

  # enable virtual
  virtualisation = {
    vmware.host.enable = true;
    vmware.guest.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            })
            .fd
          ];
        };
      };
    };

    #virt network
    # libvirtd.qemu.networks.default.enable = true;
  };

  # Enable virt-manager as a top-level program
  programs.virt-manager.enable = true;
}
