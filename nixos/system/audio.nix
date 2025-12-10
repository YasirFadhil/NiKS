{ config, pkgs, ... }:

{
  # Audio / Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
    # media-session.enable = true; # Uncomment jika perlu
  };
  boot.extraModprobeConfig = ''
    options snd-intel-dspcfg dsp_driver=3
    options snd-sof-intel-hda-common hda_model=alc5682
    options snd-hda-intel jackpoll_ms=1
  '';
  hardware.firmware = with pkgs; [
    linux-firmware
    sof-firmware
  ];

  # Bluetooth
  services.blueman.enable = true; # (opsional, untuk GUI tray Bluetooth)
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
