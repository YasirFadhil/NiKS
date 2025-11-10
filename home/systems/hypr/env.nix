{pkgs, config, ...}:

{
  wayland.windowManager.hyprland = {
  enable = true;
  xwayland.enable = true;
  settings = {
    env = [
        # ######### Input method ##########
        "QT_IM_MODULE = fcitx"
        "XMODIFIERS = @im=fcitx"
        # GTK_IM_MODULE = "wayland";   # Crashes electron apps in xwayland
        # GTK_IM_MODULE = "fcitx";     # My Gtk apps no longer require this to work with fcitx5 hmm
        "SDL_IM_MODULE = fcitx"
        "GLFW_IM_MODULE = ibus"
        "INPUT_METHOD = fcitx"

        "GTK_IM_MODULE = fcitx"
        "GTK_THEME,WhiteSur-Dark"
        "QT_IM_MODULE = fcitx"
        "XMODIFIERS = @im=fcitx"

        # ############ Themes #############
        # Qt themes now managed in themes/qt/default.nix
        # QT_STYLE_OVERRIDE = "kvantum";
        # WLR_NO_HARDWARE_CURSORS = "1";
        "GDK_BACKEND = wayland,x11,*"

        # ############ Desktop Environment #############
        "XDG_CURRENT_DESKTOP = Hyprland"
        "XDG_SESSION_DESKTOP = Hyprland"

        # ######## Screen tearing #########
        # WLR_DRM_NO_ATOMIC = "1";

        # ############ Others #############
        "SSH_AUTH_SOCK = $XDG_RUNTIME_DIR/ssh-agent.socket"
      ];
    };
  };
}
