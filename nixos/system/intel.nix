{ pkgs, ... }: {
  # Intel graphics kernel module loading
  boot = {
    initrd.kernelModules = [ "i915" ];

    # Intel graphics optimizations to reduce flickering
    kernelParams = [
      "i915.enable_psr=0"        # Disable panel self refresh (major cause of flickering)
      "i915.enable_fbc=0"        # Disable framebuffer compression
      "i915.modeset=1"           # Enable kernel mode setting
      "i915.enable_rc6=0"        # Disable render context 6
      "i915.enable_dc=0"         # Disable display C-states
      "i915.disable_power_well=1" # Disable power well
      "i915.semaphores=1"        # Enable semaphores
      "intel_idle.max_cstate=1"  # Limit CPU power states
      "acpi_backlight=vendor"    # Use vendor backlight control
    ];
  };

  # Package overrides for Intel VA-API driver
  nixpkgs.config.packageOverrides = pkgs: {
    # Avoid using intel-vaapi-driver for newer generations
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override {
      enableHybridCodec = false;
    };
  };

  # Graphics hardware configuration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver   # LIBVA_DRIVER_NAME=iHD (preferred for newer Intel)
      intel-vaapi-driver   # Legacy VA-API driver
      libvdpau-va-gl      # VDPAU support via VA-API
      libva-utils         # VA-API utilities for debugging
      vpl-gpu-rt          # Intel Video Processing Library
    ];
  };

  # X11 video driver configuration
  services.xserver.videoDrivers = [ "modesetting" ];

  # Environment variables for Intel graphics
  environment.variables = {
    # Intel VA-API driver selection
    LIBVA_DRIVER_NAME = "iHD";  # Use Intel Media Driver
    # Disable hardware acceleration for problematic applications
    WEBKIT_DISABLE_COMPOSITING_MODE = "1";
    # Force software rendering for GTK to eliminate flickering
    GSK_RENDERER = "cairo";
    GDK_RENDERING = "disabled";
    # Clutter (GNOME compositor) anti-flicker settings
    CLUTTER_PAINT = "disable-clipped-redraws:disable-culling";
    CLUTTER_VBLANK = "none";
  };
}
