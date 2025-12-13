-- Fix for Intel SOF audio devices with RT5682 codec
-- This fixes speaker/headphone detection and routing issues

rule = {
  matches = {
    {
      { "device.name", "equals", "alsa_card.pci-0000_00_0e.0-platform-glk_rt5682_def" },
    },
  },
  apply_properties = {
    -- Force auto profile switching
    ["api.acp.auto-port"] = true,
    ["api.acp.auto-profile"] = true,

    -- Prefer output over pro-audio profile
    ["device.profile.default"] = "output:analog-stereo",
  },
}

table.insert(alsa_monitor.rules, rule)

-- Fix for speaker output routing
speaker_rule = {
  matches = {
    {
      { "node.name", "matches", "alsa_output.pci-0000_00_0e.0*" },
    },
  },
  apply_properties = {
    -- Ensure speakers are always available
    ["audio.position"] = "FL,FR",
    ["node.description"] = "Built-in Speakers",

    -- Priority settings
    ["priority.driver"] = 1000,
    ["priority.session"] = 1000,
  },
}

table.insert(alsa_monitor.rules, speaker_rule)

-- Fix jack detection to prioritize speakers when nothing is plugged
jack_rule = {
  matches = {
    {
      { "node.name", "matches", "alsa_output.*glk_rt5682.*" },
    },
  },
  apply_properties = {
    -- Don't wait for jack detection
    ["api.alsa.use-ucm"] = true,
    ["api.alsa.jack-device"] = false,
  },
}

table.insert(alsa_monitor.rules, jack_rule)
