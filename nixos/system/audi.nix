{ config, pkgs, ... }:

{
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  boot.kernelParams = [
    "snd-intel-dspcfg.dsp_driver=3"
    "snd_hda_intel.power_save=0"
  ];

  boot.extraModprobeConfig = ''
    options snd-sof-intel-hda-common hda_model=glk-rt5682-max
    options sof_firmware=intel/sof/sof-glk.ri,intel/sof-tplg/sof-glk-rt5682.tplg
  '';

  hardware.firmware = [ pkgs.sof-firmware pkgs.linux-firmware ];

  # ← Tambahin satu baris ini saja (pasti beres)
  environment.variables.ALSA_CONFIG_UCM2 = "${pkgs.alsa-ucm-conf}/share/alsa/ucm2";
}
