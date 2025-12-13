{ config, pkgs, lib, ... }:

let
  # Create custom ACP profile set that adds speakers without jack detection
  customAcpProfileSet = pkgs.writeTextDir "share/alsa-card-profile/mixer/profile-sets/sof-glkrt5682max.conf" ''
    [General]
    auto-profiles = yes

    [Mapping analog-stereo-speaker]
    description = Speakers
    device-strings = hw:%f,0
    channel-map = left,right
    paths-output = analog-output-speaker-always
    direction = output
    priority = 100

    [Mapping analog-stereo-headphones]
    description = Headphones
    device-strings = hw:%f,1
    channel-map = left,right
    paths-output = analog-output-headphones
    direction = output
    priority = 90

    [Profile output:analog-stereo]
    description = Analog Stereo Output
    output-mappings = analog-stereo-speaker analog-stereo-headphones
    priority = 6000
    skip-probe = no
  '';

  # Create custom speaker output path without jack requirement
  customSpeakerPath = pkgs.writeTextDir "share/alsa-card-profile/mixer/paths/analog-output-speaker-always.conf" ''
    [General]
    description = Speakers
    type = speaker
    priority = 100

    [Properties]
    device.icon_name = audio-speakers

    [Element Spk]
    switch = mute
    volume = ignore

    [Element Speaker]
    switch = mute
    volume = merge
    override-map.1 = all
    override-map.2 = all-left,all-right

    [Element Master]
    switch = mute
    volume = merge

    [Element PCM]
    switch = mute
    volume = merge
  '';

  # Create headphones output path with jack detection
  customHeadphonesPath = pkgs.writeTextDir "share/alsa-card-profile/mixer/paths/analog-output-headphones.conf" ''
    [General]
    description = Headphones
    type = headphones
    priority = 90

    [Properties]
    device.icon_name = audio-headphones

    [Jack Headphone]
    required-any = any

    [Element Headphone Jack]
    switch = mute

    [Element HPOL]
    switch = mute
    volume = merge

    [Element HPOR]
    switch = mute
    volume = merge

    [Element Master]
    switch = mute
    volume = merge

    [Element PCM]
    switch = mute
    volume = merge
  '';

in
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

    wireplumber = {
      enable = true;
      configPackages = [
        customAcpProfileSet
        customSpeakerPath
        customHeadphonesPath

        # Configure WirePlumber to use our custom profile set
        (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/51-sof-custom-profile.conf" ''
          monitor.alsa.rules = [
            {
              matches = [
                {
                  device.name = "alsa_card.pci-0000_00_0e.0-platform-glk_rt5682_def"
                }
              ]
              actions = {
                update-props = {
                  api.alsa.use-acp = true
                  api.alsa.use-ucm = false
                  api.acp.auto-profile = true
                  api.acp.auto-port = true
                  device.profile-set = "sof-glkrt5682max.conf"
                }
              }
            }
          ]
        '')

        # Set speaker port as default and always available
        (pkgs.writeTextDir "share/wireplumber/main.lua.d/51-speaker-default.lua" ''
          -- Force speaker output to be available
          table.insert(alsa_monitor.rules, {
            matches = {
              {
                { "node.name", "matches", "alsa_output.*glk_rt5682.*speaker*" },
              },
            },
            apply_properties = {
              ["priority.driver"] = 2000,
              ["priority.session"] = 2000,
              ["node.pause-on-idle"] = false,
            },
          })
        '')
      ];
    };
  };

  # Kernel module options for Intel SOF audio
  boot.extraModprobeConfig = ''
    options snd-intel-dspcfg dsp_driver=3
    options snd-sof-intel-hda-common hda_model=alc5682
  '';

  # Required firmware
  hardware.firmware = with pkgs; [
    linux-firmware
    sof-firmware
  ];

  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
